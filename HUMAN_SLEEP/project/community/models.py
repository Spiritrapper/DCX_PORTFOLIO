from django.db import models
from account.models import User

class Question_1(models.Model):
    subject = models.CharField(max_length = 300)
    content = models.TextField()
    create_date = models.DateTimeField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    modify_date = models.DateTimeField(null=True, blank = True)
    def __str__(self):
        return self.subject

class Answer_1(models.Model):
    question = models.ForeignKey(Question_1, on_delete = models.CASCADE)
    content = models.TextField()
    create_date = models.DateField()


class Question_2(models.Model):
    subject = models.CharField(max_length = 300)
    content = models.TextField()
    create_date = models.DateTimeField()
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    modify_date = models.DateTimeField(null=True, blank = True)

    def __str__(self):
        return self.subject

class Answer_2(models.Model):
    question = models.ForeignKey(Question_2, on_delete = models.CASCADE)
    content = models.TextField()
    create_date = models.DateField()
