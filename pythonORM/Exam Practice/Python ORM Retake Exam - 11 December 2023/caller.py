import os
import django
from django.db.models import Count

from main_app.models import TennisPlayer, Match, Tournament

# Set up Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "orm_skeleton.settings")
django.setup()

# Import your models here

# Create queries within functions
def get_tennis_players(search_name=None, search_country=None):
    if not search_name and not search_country:
        return ''


    if search_name and search_country:
        tennis_players = TennisPlayer.objects.filter(full_name__icontains=search_name, country__icontains=search_country)

    elif search_country:
        tennis_players = TennisPlayer.objects.filter(country__icontains=search_country)
    else:
        tennis_players = TennisPlayer.objects.filter(full_name__icontains=search_name)

    return_str = ''
    for tennis_player in tennis_players:
        return_str += f'Tennis Player: {tennis_player.full_name}, country: {tennis_player.country}, ranking: {tennis_player.ranking}\n'

    return return_str.rstrip()

def get_top_tennis_player():
    top_player = TennisPlayer.objects.get_tennis_players_by_wins_count().first()

    if not top_player:
        return ''
    return f"Top Tennis Player: {top_player.full_name} with {top_player.matches_won.count()} wins."

def get_tennis_player_by_matches_count():
    player = TennisPlayer.objects.annotate(num_matches=Count('matches')).order_by('-num_matches', 'ranking').first()

    if not player or not player.matches.exists():
        return ''

    return f"Tennis Player: {player.full_name} with {player.num_matches} matches played."

def get_tournaments_by_surface_type(surface=None):
    if surface is None:
        return ''

    tournaments = Tournament.objects.filter(surface_type__icontains=surface).annotate(match_count=Count('matches')).order_by('-start_date')

    if not tournaments.exists():
        return ''

    return_str = ''
    for tournament in tournaments:
        return_str += f'Tournament: {tournament.name}, start date: {tournament.start_date}, matches: {tournament.match_count}\n'
    return return_str.rstrip()



def get_latest_match_info():
    latest_match: Match = Match.objects.order_by('-date_played', '-id').first()
    if not latest_match:
        return ''
    return f'Latest match played on: {latest_match.date_played}, tournament: {latest_match.tournament.name}, score: {latest_match.score}, players: {" vs ".join(p.full_name for p in latest_match.players.all().order_by("full_name"))}, winner: {"TBA" if not latest_match.winner else latest_match.winner.full_name}, summary: {latest_match.summary}'


def get_matches_by_tournament(tournament_name=None):
    if tournament_name is None:
        return "No matches found."

    matches = Match.objects.select_related('tournament', 'winner') \
        .filter(tournament__name__exact=tournament_name) \
        .order_by('-date_played')

    if not matches:
        return "No matches found."

    match_info = []
    [match_info.append(f"Match played on: {match.date_played}, score: {match.score}, winner: {match.winner.full_name if match.winner else 'TBA'}") for match in matches]

    return '\n'.join(match_info)
