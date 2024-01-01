from django.urls import path
from . import views

app_name = "community"

urlpatterns = [
    path("1/", views.community_1, name= 'community_1'),
    path("1/<int:question_id>/", views.community_1_detail, name= 'community_1_detail'),
    path("1/question/create/", views.question_create_1, name = "question_create_1"),
    path("1/answer/create/<int:question_id>/", views.answer_create_1, name= 'answer_create_1'),
    path("1/question/modify/<int:question_id>/", views.question_modify_1, name= 'question_modify_1'),
    path("1/question/delete/<int:question_id>/", views.question_delete_1, name="question_delete_1"),

    path("2/", views.community_2, name= 'community_2'),
    path("2/<int:question_id>/", views.community_2_detail, name= 'community_2_detail'),
    path("2/question/create/", views.question_create_2, name = "question_create_2"),
    path("2/answer/create/<int:question_id>/", views.answer_create_2, name= 'answer_create_2'),
    path("2/question/modify/<int:question_id>/", views.question_modify_2, name= 'question_modify_2'),
    path("2/question/delete/<int:question_id>/", views.question_delete_2, name="question_delete_2"),

    path("3/", views.community_3, name= 'community_3'),
]
