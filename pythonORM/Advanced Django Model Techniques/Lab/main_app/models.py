from django.core.exceptions import ValidationError
from django.core.validators import MaxLengthValidator, MinLengthValidator, MinValueValidator, MaxValueValidator
from django.db import models
from django.db.models import Index


# Create your models here.
class Restaurant(models.Model):
    name = models.CharField(max_length=100, validators=[MinLengthValidator(2, message='Name must be at least 2 characters long.'), MaxLengthValidator(100, message='Name cannot exceed 100 characters.')])
    location = models.CharField(max_length=200,validators=[MinLengthValidator(2, message='Location must be at least 2 characters long.'), MaxLengthValidator(200, message='Location cannot exceed 200 characters.')])
    description = models.TextField(null=True, blank=True)
    rating = models.DecimalField(decimal_places=2, max_digits=3, validators=[MinValueValidator(0, message='Rating must be at least 0.00.'), MaxValueValidator(5, message='Rating cannot exceed 5.00.')])

def validate_menu_categories(value):
    if 'appetizers' not in value.lower() or 'main course' not in value.lower() or 'desserts' not in value.lower():
        raise ValidationError('The menu must include each of the categories "Appetizers", "Main Course", "Desserts".')

class Menu(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(validators=[validate_menu_categories])
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)

class ReviewMixin(models.Model):
    reviewer_name = models.CharField(max_length=100)
    review_content = models.TextField()
    rating = models.PositiveIntegerField(validators=[MaxValueValidator(5)])

    class Meta:
        abstract = True
        ordering = ['-rating']

class RestaurantReview(ReviewMixin):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)

    class Meta(ReviewMixin.Meta):
        verbose_name = 'Restaurant Review'
        verbose_name_plural = 'Restaurant Reviews'
        unique_together = (('reviewer_name', 'restaurant'),)

class MenuReview(ReviewMixin):
    menu = models.ForeignKey(Menu, on_delete=models.CASCADE)

    class Meta(ReviewMixin.Meta):
        verbose_name = 'Menu Review'
        verbose_name_plural = 'Menu Reviews'
        unique_together = (('reviewer_name', 'menu'),)

        indexes = [
            Index(fields=['menu'], name='main_app_menu_review_menu_id')
        ]
