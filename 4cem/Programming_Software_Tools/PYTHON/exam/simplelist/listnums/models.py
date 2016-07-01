from django.db import models

# Create your models here.


class Examination(models.Model  ):
    name = models.TextField()
    duration = models.IntegerField()