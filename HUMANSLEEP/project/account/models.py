from django.db import models
from django.contrib.auth.models import AbstractUser	# AbstractUser 불러오기

class User(AbstractUser):
    nickname = models.CharField(max_length = 20, null=True, blank=True)
    name = models.CharField(max_length = 20, null=True, blank=True)
    phone_num = models.CharField(max_length = 50, null=True, blank=True)
    birth = models.CharField(max_length = 20, null=True, blank=True)
    email = models.EmailField(max_length = 50, null=True, blank=True)
    target_sleep = models.TimeField(max_length = 10, null=True, blank=True)