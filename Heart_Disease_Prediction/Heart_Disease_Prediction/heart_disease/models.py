# heart_disease/models.py
from django.db import models

class PatientData(models.Model):
    age = models.FloatField()
    sex = models.CharField(max_length=10)
    cp = models.FloatField()
    trestbps = models.FloatField()
    chol = models.FloatField()
    fbs = models.FloatField()
    restecg = models.FloatField()
    thalach = models.FloatField()
    exang = models.FloatField()
    oldpeak = models.FloatField()
    slope = models.FloatField()
    ca = models.FloatField()
    thal = models.FloatField()
    target = models.IntegerField()

    def __str__(self):
        return f"Patient {self.id} - {self.target}"



class NewsArticle(models.Model):
    title = models.CharField(max_length=200)
    link = models.URLField()
    description = models.TextField(blank=True, null=True)
    image_url = models.URLField(blank=True, null=True)  

    def __str__(self):
        return self.title
