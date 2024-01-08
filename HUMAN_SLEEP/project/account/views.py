from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from .forms import SignUpForm

# Create your views here.

def login_user(request):
    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username = username, password = password)
        if user is not None:
            login(request, user)
            messages.success(request, f"{username}님 환영합니다.")
            return redirect('home:home')
        else:
            messages.success(request, "다시 입력해주세요")
            return redirect('home:home') 
    return redirect('home:home')


def logout_user(request):
    logout(request)
    messages.success(request, "로그아웃되었습니다.")
    return redirect('home:home')

def register_user(request):
    if request.method == "POST":
        form = SignUpForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data['username']
            password = form.cleaned_data['password1']
            user = authenticate(username = username, password = password)
            login(request, user)
            messages.success(request, "회원가입되었습니다")
            return redirect('home:home')
        else:
            messages.success(request, "뭔가 잘못되었습니다. 다시 작성해주세요")
            return render(request, "account/register.html", {'form' : form})
    else:
        form = SignUpForm
    return render(request, "account/register.html", {'form' : form})