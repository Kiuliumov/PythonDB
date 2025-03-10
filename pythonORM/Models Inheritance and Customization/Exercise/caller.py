import os
import django
from main_app.models import Student
from orm_skeleton import settings

# Set up Django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "orm_skeleton.settings")
django.setup()

student1 = Student(name="Alice", student_id=45.23)

student1.full_clean()

student1.save()

retrieved_student1 = Student.objects.get(name="Alice")


print(retrieved_student1.student_id)


try:
    student2 = Student(name="Bob", student_id="0")
    student1.full_clean()

    student2.save()
except ValueError as error:
    print(error)
