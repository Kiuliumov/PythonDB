# Generated by Django 5.1.4 on 2025-02-19 19:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0004_driver_drivinglicense'),
    ]

    operations = [
        migrations.AlterField(
            model_name='drivinglicense',
            name='license_number',
            field=models.CharField(max_length=10, unique=True),
        ),
    ]
