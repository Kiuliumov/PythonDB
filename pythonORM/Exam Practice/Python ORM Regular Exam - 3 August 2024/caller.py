import os
import django
from django.db.models import Q, Count, Sum

from main_app.models import Astronaut, Mission, Spacecraft

# Set up Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "orm_skeleton.settings")
django.setup()

# Import your models here

# Create queries within functions

def get_astronauts(search_string=None):
    if search_string is None:
        return ''

    astronauts = Astronaut.objects.all()
    astronauts = astronauts.filter(
        Q(name__icontains=search_string) | Q(phone_number__icontains=search_string)
    )

    if not astronauts.exists():
        return ''

    astronauts = astronauts.order_by('name')

    return '\n'.join([
        f'Astronaut: {a.name}, phone number: {a.phone_number}, status: {"Active" if a.is_active else "Inactive"}'
        for a in astronauts
    ])

def get_top_astronaut():
    if not Astronaut.objects.exists() or not Mission.objects.exists():
        return 'No data.'

    top_astronaut = Astronaut.objects.annotate(missions_count=Count('missions')).order_by('-missions_count', 'phone_number').first()

    return f'Top Astronaut: {top_astronaut.name} with {top_astronaut.missions_count} missions.'

def get_top_commander():
    if not Astronaut.objects.exists() or not Mission.objects.exists() or not Mission.objects.filter(commander__isnull=False).exists():
        return 'No data.'

    top_commander = Astronaut.objects.annotate(missions_led_count=Count('missions_led')).order_by('-missions_led_count', 'phone_number').first()

    return f'Top Commander: {top_commander.name} with {top_commander.missions_led_count} commanded missions.'

def get_last_completed_mission():
    mission = Mission.objects.filter(status='Completed').order_by('-launch_date').first()

    if not mission:
        return f'No data.'

    astronaut_names = [astronaut.name for astronaut in mission.astronauts.order_by('name')]
    total_spacewalks = sum(astronaut.spacewalks for astronaut in mission.astronauts.all())
    return f'The last completed mission is: {mission.name}. Commander: {mission.commander.name if mission.commander else "TBA"}. Astronauts: {", ".join(astronaut_names)}. Spacecraft: {mission.spacecraft.name}. Total spacewalks: {total_spacewalks}.'


def get_most_used_spacecraft():
    if not Mission.objects.exists():
        return "No data."
    spacecraft = Spacecraft.objects.annotate(num_missions=Count('missions')).order_by('-num_missions', 'name').first()
    if spacecraft:
        astronauts = spacecraft.missions.values('astronauts').distinct().count()
        return f"The most used spacecraft is: {spacecraft.name}, manufactured by {spacecraft.manufacturer}, used in {spacecraft.num_missions} missions, astronauts on missions: {astronauts}."
    return "No data."


def decrease_spacecrafts_weight():
    spacecrafts_in_planned_missions = Spacecraft.objects.filter(
        missions__status='Planned'
    ).distinct()

    spacecrafts_to_decrease = spacecrafts_in_planned_missions.filter(
        weight__gte=200.0
    )

    for spacecraft in spacecrafts_to_decrease:
        spacecraft.weight = max(spacecraft.weight - 200.0, 0.0)
        spacecraft.save()

    num_of_spacecrafts_affected = spacecrafts_to_decrease.count()

    if num_of_spacecrafts_affected == 0:
        return "No changes in weight."

    total_weight = Spacecraft.objects.aggregate(total_weight=Sum('weight'))['total_weight']
    total_spacecrafts = Spacecraft.objects.count()

    if total_spacecrafts > 0:
        avg_weight = total_weight / total_spacecrafts
    else:
        avg_weight = 0.0

    return f"The weight of {num_of_spacecrafts_affected} spacecrafts has been decreased. The new average weight of all spacecrafts is {avg_weight:.1f}kg"