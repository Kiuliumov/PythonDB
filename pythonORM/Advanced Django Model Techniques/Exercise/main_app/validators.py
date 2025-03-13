from django.core.exceptions import ValidationError

class Validators:
    @staticmethod
    def name_validator(value: str):
        if not value.replace(' ', "").isalpha():
            raise ValidationError('Name can only contain letters and spaces')


    @staticmethod
    def phone_validator(value: str):
        req = [value.startswith('+359'), value.__len__() == 13]
        if not all(req):
            raise ValidationError('Phone number must start with \'+359\' followed by 9 digits')

