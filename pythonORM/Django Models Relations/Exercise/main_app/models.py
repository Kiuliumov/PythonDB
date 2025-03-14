from django.db import models

# Create your models here.
class Author(models.Model):
    name = models.CharField(max_length=40)

class Book(models.Model):
    title = models.CharField(max_length=40)
    price = models.DecimalField(max_digits=5, decimal_places=2)
    author = models.ForeignKey(to=Author, on_delete=models.CASCADE)


class Song(models.Model):
    title = models.CharField(max_length=100)

class Artist(models.Model):
    name = models.CharField(max_length=100)
    songs = models.ManyToManyField(Song, related_name='artists')

class Product(models.Model):
    name = models.CharField(max_length=100)

class Review(models.Model):
    description = models.CharField(max_length=200)
    rating = models.PositiveSmallIntegerField()
    product = models.ForeignKey(Product, related_name='reviews', on_delete=models.CASCADE, null=True, blank=True)

class Driver(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)

class DrivingLicense(models.Model):
    license_number = models.CharField(max_length=10, unique=True)
    issue_date = models.DateField()
    driver = models.ForeignKey(Driver,related_name='license', on_delete=models.CASCADE)

