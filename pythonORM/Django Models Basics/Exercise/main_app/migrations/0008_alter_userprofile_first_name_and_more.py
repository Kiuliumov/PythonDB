# Generated by Django 5.0.4 on 2024-12-16 11:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main_app', '0007_alter_userprofile_first_name_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='first_name',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='last_name',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
    ]
