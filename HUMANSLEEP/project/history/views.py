from django.shortcuts import render, redirect
from django.contrib.auth import authenticate
from django.contrib import messages
from history.models import User_history
from datetime import datetime, timedelta
from django.contrib.auth.decorators import login_required
import ast

@login_required
def history(request):
    check_str = ["평소 취침시간과 동일하게 취침하시나요?",
    "운동 전에 격렬한 운동을 하지 않았나요?",
    "오후 5시 이후에 카페인을 섭취하셨나요?",
    "낮잠을 주무셨나요?",
    "저녁에 과식을 하셨나요?",
    "7시 이후에 흡연을 하셨나요?",
    "취침 2시간 이내에 음주를 하셨나요?",
    "취침에 들기에 편안한 환경이신가요?"]
    if request.user.is_authenticated:
        user_history = User_history.objects.filter(user_id = request.user.id)
        # check_list_real = []
        for row in user_history.values_list():
            list = row[5]
            # check_list_num = ast.literal_eval(list)
            # for i in check_list_num:
            #     check_list_real.append(int(check_str[i]))
        sleep_awake_diffs = []
        for history_entry in user_history:
            sleep_time = history_entry.sleep_time
            awake_time = history_entry.awake_time
            diff_minutes = (awake_time.minute - sleep_time.minute) % 60
            diff_hours = (awake_time.hour - sleep_time.hour) + (awake_time.minute - sleep_time.minute) // 60

            if diff_hours < 0:
                diff_hours += 24

            sleep_awake_diffs.append((diff_hours, diff_minutes))

        total_diffs = len(sleep_awake_diffs)  
        if total_diffs > 0:
            total_hours = sum(hours for hours, minutes in sleep_awake_diffs)
            total_minutes = sum(minutes for hours, minutes in sleep_awake_diffs)
            average_hours = total_hours // total_diffs
            average_minutes = total_minutes // total_diffs
            average_time_diff = (average_hours, average_minutes)
        else:
            average_time_diff = None

        return render(request, "history/history.html", {"user_history" : user_history, "list" : list, "sleep_awake_diffs": sleep_awake_diffs, "average_time_diff": average_time_diff})
    else :
        messages.success(request, "로그인이 필요합니다.")
        return redirect("home:home")
    
def delete_history(request, history_id):    
    past = User_history.objects.get(pk = history_id)
    past.delete()
    messages.success(request, "삭제되었습니다.")
    return redirect('history:history')