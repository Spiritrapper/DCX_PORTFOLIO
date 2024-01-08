from django.db import models

# Create your models here.
class CrawledData(models.Model):
    title = models.CharField(max_length=300)
    link = models.URLField(max_length=300)
    img_link = models.URLField(max_length=300)
    text_file = models.FileField(upload_to='text_files/', null=True, blank=True)
    image_file = models.ImageField(upload_to='image_file/', null=True, blank=True)