# Generated by Django 5.1.4 on 2025-03-10 11:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0007_menureview_main_app_menu_review_menu_id'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='menureview',
            options={'ordering': ['-rating'], 'verbose_name': 'Menu Review', 'verbose_name_plural': 'Menu Reviews'},
        ),
        migrations.AlterModelOptions(
            name='restaurantreview',
            options={'ordering': ['-rating'], 'verbose_name': 'Restaurant Review', 'verbose_name_plural': 'Restaurant Reviews'},
        ),
    ]
