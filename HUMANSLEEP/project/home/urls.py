from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static

app_name = "home"

urlpatterns = [
    path("", views.home, name= 'home'),
    path("display_data/",views.display_data, name='display_data'),
    path("save_db/",views.save_csv_to_db, name='save_db')
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)