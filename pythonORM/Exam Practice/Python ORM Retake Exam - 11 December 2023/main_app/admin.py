from django.contrib import admin
from .models import TennisPlayer, Tournament, Match

@admin.register(TennisPlayer)
class TennisPlayerAdmin(admin.ModelAdmin):
    list_display = ('full_name', 'country', 'ranking', 'is_active')
    list_filter = ('is_active',)
    search_fields = ('full_name', 'country')

@admin.register(Tournament)
class TournamentAdmin(admin.ModelAdmin):
    list_display = ('name', 'location', 'prize_money', 'surface_type', 'start_date')
    list_filter = ('surface_type',)
    search_fields = ('name', 'location')
@admin.register(Match)
class MatchAdmin(admin.ModelAdmin):
    list_display = ('date_played', 'score', 'summary')
    list_filter = ('date_played',)
    search_fields = ('tournament__name',)

