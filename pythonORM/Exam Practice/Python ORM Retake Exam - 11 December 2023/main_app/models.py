from django.core.validators import MinLengthValidator, MinValueValidator, MaxValueValidator
from django.db import models
from django.db.models import Count


# Create your models here.

class CustomModelManager(models.Manager):
    def get_tennis_players_by_wins_count(self):
        return self.get_queryset().annotate(wins=Count('matches_won')).order_by('-wins', 'full_name')


class TennisPlayer(models.Model):
    full_name = models.CharField(max_length=120, validators=[MinLengthValidator(5)])
    birth_date = models.DateField()
    country = models.CharField(max_length=100, validators=[MinLengthValidator(2)])
    ranking = models.PositiveIntegerField(validators=[MinValueValidator(1), MaxValueValidator(300)])
    is_active = models.BooleanField(default=True)

    objects = CustomModelManager()

class Tournament(models.Model):
    name = models.CharField(max_length=150, validators=[MinLengthValidator(2)], unique=True)
    location = models.CharField(max_length=100, validators=[MinLengthValidator(2)])
    prize_money = models.DecimalField(max_digits=10, decimal_places=2)
    start_date = models.DateField()
    surface_type = models.CharField(max_length=12, choices=(('Not Selected', 'Not Selected'), ('Clay', 'Clay'), ('Grass', 'Grass'), ('Hard Court', 'Hard Court')), default='Not Selected')

class Match(models.Model):
    score = models.CharField(max_length=100)
    summary = models.TextField(validators=[MinLengthValidator(5)])
    date_played = models.DateTimeField()
    tournament = models.ForeignKey(Tournament, on_delete=models.CASCADE, related_name='matches')
    players = models.ManyToManyField(TennisPlayer, related_name='matches')
    winner = models.ForeignKey(TennisPlayer, on_delete=models.SET_NULL, null=True, related_name='matches_won')

    class Meta:
        verbose_name_plural = 'Matches'
