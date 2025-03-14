from django.db import models

# Create your models here.

class BaseCharacter(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()

    class Meta:
        abstract = True

class Mage(BaseCharacter):
    elemental_power = models.CharField(max_length=100)
    spellbook_type = models.CharField(max_length=100)

class Assassin(BaseCharacter):
    weapon_type = models.CharField(max_length=100)
    assassination_technique = models.CharField(max_length=100)

class DemonHunter(BaseCharacter):
    weapon_type = models.CharField(max_length=100)
    demon_slaying_ability = models.CharField(max_length=100)

class TimeMage(Mage):
    time_magic_mastery = models.CharField(max_length=100)
    temporal_shift_ability = models.CharField(max_length=100)

class Necromancer(Mage):
    raise_dead_ability = models.CharField(max_length=100)

class ViperAssassin(Assassin):
    venomous_strikes_mastery = models.CharField(max_length=100)
    venomous_bite_ability = models.CharField(max_length=100)

class ShadowbladeAssassin(Assassin):
    shadowstep_ability = models.CharField(max_length=100)

class VengeanceDemonHunter(DemonHunter):
    vengeance_mastery = models.CharField(max_length=100)
    retribution_ability = models.CharField(max_length=100)

class FelbladeDemonHunter(DemonHunter):
    felblade_ability = models.CharField(max_length=100)


class UserProfile(models.Model):
    username = models.CharField(max_length=70, unique=True)
    email = models.EmailField(unique=True)
    bio = models.TextField(blank=True, null=True)

class Message(models.Model):
    sender = models.ForeignKey(to=UserProfile, on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey(to=UserProfile, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)

    def mark_as_read(self):
        self.is_read = True
        self.save()

    def reply_to_message(self, reply_content: str):
        message = Message.objects.create(
            sender=self.receiver,
            receiver=self.sender,
            content=reply_content
        )
        return message

    def forward_message(self, receiver):
        message = Message.objects.create(
            sender=self.receiver,
            receiver=receiver,
            content=self.content
        )
        return message


class ValidationError:
    pass


class StudentIDField(models.PositiveIntegerField):

    @staticmethod
    def validate_field(value) -> int:
        try:
            return int(value)
        except ValueError:
            raise ValueError("Invalid input for student ID")

    def to_python(self, value) -> int:
        return self.validate_field(value)

    def get_prep_value(self, value) -> int:
        validated_value = self.validate_field(value)

        if validated_value <= 0:
            raise ValidationError("ID cannot be less than or equal to zero")

        return validated_value

class Student(models.Model):
    name = models.CharField(max_length=100)
    student_id = StudentIDField()
