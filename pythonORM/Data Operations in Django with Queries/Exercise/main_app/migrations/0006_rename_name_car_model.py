# Generated by Django 5.1.4 on 2024-12-18 05:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0005_car'),
    ]

    operations = [
        migrations.RenameField(
            model_name='car',
            old_name='name',
            new_name='model',
        ),
    ]
