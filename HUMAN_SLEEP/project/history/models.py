from django.db import models
from account.models import User

class User_history(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    sleep_time = models.TimeField()
    awake_time = models.TimeField()
    date = models.DateField(default=None, null=True)
    checklist = models.CharField(max_length=50, default=None, null=True)
