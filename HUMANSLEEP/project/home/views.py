from django.shortcuts import render, redirect
from history.models import User_history
from django.utils import timezone
from .models import CrawledData
import csv
from django.core.files.base import ContentFile
import os
from django.conf import settings
from django.core.files import File
import random
import ast


# Create your views here.
def home(request):
    checklist = ["평소 취침시간과 동일하게 취침하시나요?",
    "운동 전에 격렬한 운동을 하지 않았나요?",
    "오후 5시 이후에 카페인을 섭취하셨나요?",
    "낮잠을 주무셨나요?",
    "저녁에 과식을 하셨나요?",
    "7시 이후에 흡연을 하셨나요?",
    "취침 2시간 이내에 음주를 하셨나요?",
    "취침에 들기에 편안한 환경이신가요?"]

    if request.method == "POST":
        sleep_time = request.POST["sleep_time"]
        awake_time = request.POST["awake_time"]
        checklist = request.POST.getlist('category', '')
        date = timezone.now()
        record = User_history(sleep_time = sleep_time, awake_time = awake_time, checklist = checklist, date = date, user = request.user)
        record.save()
        for i in range(1, 4):
            globals()[f'num_{i}'] = random.randrange(2, 239)
            globals()[f'data_{i}'] = CrawledData.objects.filter(id = globals()[f'num_{i}'])
            for row in globals()[f'data_{i}'].values_list():
                globals()[f'a{i}'] = row[1]
                globals()[f'b{i}'] = row[2]
                globals()[f'c{i}'] = row[3]

                globals()[f'title_{i}'] = ast.literal_eval(globals()[f'a{i}'])
                globals()[f'link_{i}'] = ast.literal_eval(globals()[f'b{i}'])
                globals()[f'image_{i}'] = ast.literal_eval(globals()[f'c{i}'])

        content = {'checklist' : checklist, "title_1" : title_1[1], "link_1" : link_1[1], "image_1" : image_1[1], 
                    "title_2" : title_2[1], "link_2" : link_2[1], "image_2" : image_2[1], 
                    "title_3" : title_3[1], "link_3" : link_3[1], "image_3" : image_3[1]}
        return render(request, "home/home.html", content)
    return render(request, "home/home.html", {'checklist' : checklist})



def save_csv_to_db(request):
    saved_data = []
    with open('media/title.csv', 'r',encoding='utf-8') as title, open('media/link.csv', 'r',encoding='utf-8') as link, open('media/img_link.csv', 'r',encoding='utf-8') as img_link:
        title_reader = csv.reader(title)
        link_reader = csv.reader(link)
        img_link_reader = csv.reader(img_link)

        for title, link, img_link in zip(title_reader, link_reader, img_link_reader):
            crawled_data = CrawledData(title=title, link=link, img_link=img_link)
            crawled_data.save()
            saved_data.append(crawled_data)
    img_link_data = img_link[0]
    img_filename = os.path.basename(img_link_data)
    img_path = os.path.join(settings.MEDIA_ROOT, 'media', img_filename)  # 이미지 파일 경로
    if os.path.exists(img_path):  # 해당 경로에 이미지 파일이 존재하는 경우에만 저장
        with open(img_path, 'rb') as img_file:
            crawled_data.image_file.save(img_filename, File(img_file), save=True)
            # crawled_data.save()
            saved_data.append( crawled_data.image_file)
            # crawled_data.image_file.save('your_image_filename.png', File(open(img_path, 'rb')))

    return render(request, "home/save_db.html", {'saved_data': saved_data})

def display_data(request):
    crawled_data = CrawledData.objects.all()
    print(crawled_data)
    return render(request, "home/display_data.html", {'crawled_data': crawled_data})
