from django.core.exceptions import ValidationError
from django.core.validators import MinLengthValidator, MinValueValidator
from django.db import models
from django.db.models import Count


def custom_validator(value):
    if not value.isdigit():
        raise ValidationError(message='')

class CustomModelManager(models.Manager):
    def get_astronauts_by_missions_count(self):
        return self.get_queryset().annotate(missions_count=Count('missions')).order_by('-missions_count', 'phone_number')
# Create your models here.
class DefaultMixin(models.Model):
    name = models.CharField(max_length=120, validators=[MinLengthValidator(2)])
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

class Astronaut(DefaultMixin):
    phone_number = models.CharField(max_length=15, validators=[custom_validator], unique=True)
    is_active = models.BooleanField(default=True)
    date_of_birth = models.DateField(null=True, blank=True)
    spacewalks = models.IntegerField(default=0, validators=[MinValueValidator(0)])

    objects = CustomModelManager()
class Spacecraft(DefaultMixin):
    manufacturer = models.CharField(max_length=100)
    capacity = models.SmallIntegerField(validators=[MinValueValidator(1)])
    weight = models.FloatField(validators=[MinValueValidator(0)])
    launch_date = models.DateField()

class Mission(DefaultMixin):
    description = models.TextField(null=True, blank=True)
    status = models.CharField(max_length=9, choices=[('Planned', 'Planned'), ('Ongoing', 'Ongoing'), ('Completed', 'Completed')], default='Planned')
    launch_date = models.DateField()
    spacecraft = models.ForeignKey(Spacecraft, on_delete=models.CASCADE, related_name='missions')
    astronauts = models.ManyToManyField(Astronaut, related_name='missions')
    commander = models.ForeignKey(Astronaut, on_delete=models.SET_NULL, related_name='missions_led', null=True)
