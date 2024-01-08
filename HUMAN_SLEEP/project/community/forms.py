from django import forms
from community.models import Question_1, Question_2


class QuestionForm_1(forms.ModelForm):
    class Meta:
        model = Question_1
        fields = ['subject', 'content']
        widgets = {
            'subject':forms.TextInput(attrs={'class':'form-control'}),
            'content':forms.Textarea(attrs={'class':'form-control', 'rows':10}),
        }
        labels = {
            'subject' : '제목',
            'content' : '내용',
        }

class QuestionForm_2(forms.ModelForm):
    class Meta:
        model = Question_2
        fields = ['subject', 'content']
        widgets = {
            'subject':forms.TextInput(attrs={'class':'form-control'}),
            'content':forms.Textarea(attrs={'class':'form-control', 'rows':10}),
        }
        labels = {
            'subject' : '제목',
            'content' : '내용',
        }