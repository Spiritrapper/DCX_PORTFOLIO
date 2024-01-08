from django.shortcuts import render, get_object_or_404, redirect
from .models import Question_1, Question_2
from django.utils import timezone
from .forms import QuestionForm_1, QuestionForm_2
import csv
from django.contrib.staticfiles import finders
from django.contrib import messages
from django.contrib.auth.decorators import login_required

# 자유게시판
def community_1(request):
    question_list = Question_1.objects.order_by('-create_date')
    context = {'question_list' : question_list}
    return render(request, "community/community_1.html", context)

def community_1_detail(request, question_id):
    question = Question_1.objects.get(id = question_id)
    context = {"question" : question}
    return render(request, 'community/community_1_detail.html', context)

def answer_create_1(request, question_id):
    question = get_object_or_404(Question_1, pk = question_id)
    question.answer_1_set.create(content=request.POST.get('content'),
                               create_date=timezone.now())    
    return redirect("community:community_1_detail", question_id = question.id)

def question_create_1(request):
    if request.method == "POST":
        form = QuestionForm_1(request.POST)
        if form.is_valid():
            question = form.save(commit=False)
            question.author = request.user
            question.create_date = timezone.now()
            question.save()
            return redirect('community:community_1')
    else:
        form = QuestionForm_1()
    return render(request, 'community/question_form.html', {'form' : form })

@login_required(login_url = "account:login_user")
def question_modify_1(request, question_id):
    question = get_object_or_404(Question_1, pk=question_id)
    if request.user != question.author:
        messages.error(request, "수정권한이 없습니다")
        return redirect("community:community_1_detail", question_id = question.id)
    
    if request.method == "POST":
        form = QuestionForm_1(request.POST, instance = question)
        if form.is_valid():
            question = form.save(commit=False)
            question.author = request.user
            question.modify_date = timezone.now()
            question.save()
            return redirect('community:community_1_detail', question_id = question.id)
    else:
        form = QuestionForm_1(instance=question)
    context = {"form" : form}
    return render(request, 'community/question_form.html', context)

def question_delete_1(request, question_id):
    question = get_object_or_404(Question_1, pk=question_id)
    if request.user != question.author:
        messages.error(request, "삭제권한이 없습니다")
        return redirect('community:community_1_detail', question_id = question.id)
    question.delete()
    return redirect("community:community_1")


# 질문게시판
@login_required(login_url = "account:login_user")
def community_2(request):
    question_list = Question_2.objects.order_by('-create_date')
    context = {'question_list' : question_list}
    return render(request, "community/community_2.html", context)

def community_2_detail(request, question_id):
    question = Question_2.objects.get(id = question_id)
    context = {"question" : question}
    return render(request, 'community/community_2_detail.html', context)

def answer_create_2(request, question_id):
    question = get_object_or_404(Question_2, pk = question_id)
    question.answer_2_set.create(content=request.POST.get('content'),
                               create_date=timezone.now())
    return redirect("community:community_2_detail", question_id = question.id)

def question_create_2(request):
    if request.method == "POST":
        form = QuestionForm_2(request.POST)
        if form.is_valid():
            question = form.save(commit=False)
            question.author = request.user
            question.create_date = timezone.now()
            question.save()
            return redirect('community:community_2')
    else:
        form = QuestionForm_1()
    return render(request, 'community/question_form.html', {'form' : form })


@login_required(login_url = "account:login_user")
def question_modify_2(request, question_id):
    question = get_object_or_404(Question_2, pk=question_id)
    if request.user != question.author:
        messages.error(request, "수정권한이 없습니다")
        return redirect("community:community_2_detail", question_id = question.id)
    
    if request.method == "POST":
        form = QuestionForm_2(request.POST, instance = question)
        if form.is_valid():
            question = form.save(commit=False)
            question.author = request.user
            question.modify_date = timezone.now()
            question.save()
            return redirect('community:community_2_detail', question_id = question.id)
    else:
        form = QuestionForm_2(instance=question)
    context = {"form" : form}
    return render(request, 'community/question_form.html', context)

def question_delete_2(request, question_id):
    question = get_object_or_404(Question_2, pk=question_id)
    if request.user != question.author:
        messages.error(request, "삭제권한이 없습니다")
        return redirect('community:community_2_detail', question_id = question.id)
    question.delete()
    return redirect("community:community_2")

# 수면 저널

def community_3(request):
    csv_path = finders.find('csv/sciencedirect_Volume66.csv')
    
    csv_data = []

    #DB 넣는 코드 작성

    if csv_path:
        with open(csv_path, 'r', encoding='utf-8') as csv_file:
            csv_reader = csv.reader(csv_file)
            csv_data = list(csv_reader)
            
            for data in csv_data:
                print(data)

    csv_path = finders.find('csv/sciencedirect_Volume70.csv')

    csv_data2 = []

    if csv_path:
     with open(csv_path, 'r', encoding='utf-8') as csv_file:
        csv_reader = csv.reader(csv_file)
        csv_data = list(csv_reader)
            
        for data in csv_data:
            print(data)


    return render(request, "community/community_3.html", {'csv_data': csv_data})