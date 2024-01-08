from django.urls import path
from . import views

app_name = "history"

urlpatterns = [
    path("", views.history, name= 'history'),
    path("<history_id>/", views.delete_history, name = "delete_history"),

]