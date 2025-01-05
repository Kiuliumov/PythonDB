import os
import django
from main_app.models import Pet, Artifact, Location, Car, Task, HotelRoom, Character

# Set up Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "orm_skeleton.settings")
django.setup()


# Import your models here

# Create queries within functions
def create_pet(name: str, species: str):
    Pet.objects.create(name=name, species=species)
    return f'{name} is a very cute {species}!'


def create_artifact(name: str, origin: str, age: int, description: str, is_magical: bool):
    Artifact.objects.create(name=name, origin=origin, age=age, description=description, is_magical=is_magical)
    return f'The artifact {name} is {age} years old!'


def rename_artifact(artifact: Artifact, new_name: str):
    if artifact.is_magical and artifact.age > 250:
        artifact.name = new_name
        artifact.save()


def delete_all_artifacts():
    Artifact.objects.all().delete()


def show_all_locations():
    all_locations = Location.objects.all().order_by('-id')
    all_locations_string = ''
    for location in all_locations:
        all_locations_string += f'{location.name} has a population of {location.population}!\n'

    return all_locations_string.rstrip()


def new_capital():
    location = Location.objects.filter(is_capital=False).first()
    location.is_capital = True
    location.save()


def get_capitals():
    return Location.objects.values('name').filter(is_capital=True)


def delete_first_location():
    Location.objects.first().delete()


def apply_discount():
    all_cars = Car.objects.all()
    for car in all_cars:
        car.price_with_discount = car.price - car.price * sum([int(x) for x in str(car.year)]) / 100
        car.save()

def get_recent_cars():
    return Car.objects.values('model', 'price_with_discount').filter(year__gt=2020)

def delete_last_car():
    Car.objects.last().delete()

def show_unfinished_tasks():
    all_tasks = Task.objects.filter(is_finished=False)
    all_tasks_string = ''
    for task in all_tasks:
        all_tasks_string += f'Task - {task.title} needs to be done until {task.due_date}!\n'
    return all_tasks_string.rstrip()

def complete_odd_tasks():
    for task in Task.objects.all():
        if task.id % 2 != 0:
            task.is_finished = True
            task.save()


def encode_and_replace(text: str, task_title: str):
    encoded_text = ''.join(chr(ord(char) - 3) for char in text)
    all_tasks = Task.objects.filter(title=task_title)
    for task in all_tasks:
        task.description = encoded_text
        task.save()


def get_deluxe_rooms():
    all_rooms = HotelRoom.objects.filter(room_type='Deluxe')
    all_rooms_string = ''
    for room in all_rooms:
        if room.id % 2 == 0:
            all_rooms_string += f'Deluxe room with number {room.room_number} costs {room.price_per_night}$ per night!\n'
    return all_rooms_string.rstrip()

def increase_room_capacity():
    all_rooms = HotelRoom.objects.all().order_by('id')
    for i in range(0, len(all_rooms)):
        room = all_rooms[i]
        if room.is_reserved:
            if i == 0:
                room.capacity = room.capacity + room.id
                room.save()
            else:
                room.capacity = room.capacity + all_rooms[i-1].capacity
                room.save()

def reserve_first_room():
    first_room = HotelRoom.objects.first()
    first_room.is_reserved = True
    first_room.save()


def delete_last_room():
    last_room = HotelRoom.objects.last()
    if not last_room.is_reserved:
        last_room.delete()


def update_characters():
    for character in Character.objects.all():
        if character.class_name == 'Mage':
            character.level += 3
            character.intelligence -= 7
        elif character.class_name == 'Warrior':
            character.hit_points *= 0.5
            character.dexterity += 4
        elif character.class_name == 'Assassin' or character.class_name == 'Scout':
            character.inventory = 'The inventory is empty'
        character.save()

def fuse_characters(first_character: Character, second_character: Character):
    inventory = 'Bow of the Elven Lords, Amulet of Eternal Wisdom' if first_character.class_name not in('Warrior', 'Assassin') else 'Dragon Scale Armor, Excalibur'
    Character.objects.create(
        name=first_character.name + ' ' + second_character.name,
        class_name='Fusion',
        level = int((first_character.level + second_character.level) // 2),
        strength= int((first_character.strength + second_character.strength) * 1.2),
        dexterity=int((first_character.dexterity + second_character.dexterity) * 1.4),
        intelligence=int((first_character.intelligence + second_character.intelligence) * 1.5),
        hit_points=first_character.hit_points + second_character.hit_points,
        inventory=inventory,
    )
    first_character.delete()
    second_character.delete()

def grand_dexterity():
    for character in Character.objects.all():
        character.dexterity = 30
        character.save()
def grand_intelligence():
    for character in Character.objects.all():
        character.intelligence = 40
        character.save()
def grand_strength():
    for character in Character.objects.all():
        character.strength = 50
        character.save()
def delete_characters():
    for character in Character.objects.all():
        if character.inventory == 'The inventory is empty':
            character.delete()
