from django.contrib.auth.forms import UserCreationForm
from django import forms
from account.models import User

class SignUpForm(UserCreationForm):
    phone_num = forms.CharField(label = "전화번호", widget=forms.TextInput(attrs = {'class':'form-control', "placeholder":"000-0000-0000"}))
    birth = forms.CharField(label = "생년월일", widget=forms.TextInput(attrs = {'class':'form-control', "placeholder":"0000/00/00"}))
    email = forms.EmailField(label = "E-mail", widget=forms.TextInput(attrs = {'class':'form-control', "placeholder":"admin@00000.000"}))
    name = forms.CharField(label="성명", max_length=100, widget = forms.TextInput(attrs = {'class':"form-control", "placeholder":"성명"}))
    nickname = forms.CharField(label="닉네임", max_length=100, widget = forms.TextInput(attrs = {'class':"form-control", "placeholder":"닉네임"}))
    target_sleep = forms.TimeField(label = "", widget=forms.TimeInput(attrs = {'class':'form-control', "placeholder":"목표 수면시간(00:00 형식으로 시간과 분을 입력해주세요)"}))

    # 필드를 추가

    class Meta:
        model = User
        fields = ('username', 'password1', 'password2', 'name', 'birth','phone_num', 'email', 'nickname', 'target_sleep')
    
    def __init__(self, *args, **kwargs):
        super(SignUpForm, self).__init__(*args, **kwargs)
 
        self.fields['username'].widget.attrs['class'] = 'form-control'
        self.fields['username'].widget.attrs['placeholder'] = 'ID'
        self.fields['username'].label = 'ID' 
        self.fields['username'].help_text = '<span class="form-text text-muted"></span>'

        self.fields['password1'].widget.attrs['class'] = 'form-control'
        self.fields['password1'].widget.attrs['placeholder'] = '비밀번호'
        self.fields['password1'].label = '비밀번호'
        self.fields['password1'].help_text = '<ul class="form-text text-muted small"><li>특수문자 포함 8글자 이상으로 입력해주세요</li></ul>'
 
        self.fields['password2'].widget.attrs['class'] = 'form-control'
        self.fields['password2'].widget.attrs['placeholder'] = '비밀번호 확인'
        self.fields['password2'].label = '비밀번호 확인'
        self.fields['password2'].help_text = '<span class="form-text text-muted"></span>'