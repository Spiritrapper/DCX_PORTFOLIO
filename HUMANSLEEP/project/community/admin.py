from django.contrib import admin
from .models import Question_1
from .models import Question_2


# Register your models here.

class QuestionAdmin(admin.ModelAdmin):
    search_field = ['subject']

admin.site.register(Question_1, QuestionAdmin)
admin.site.register(Question_2, QuestionAdmin)