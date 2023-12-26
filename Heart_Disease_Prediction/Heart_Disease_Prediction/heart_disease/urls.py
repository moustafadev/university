# heart_disease/urls.py
from django.urls import path
from .views import predict_diagnosis,scrape_google_news

urlpatterns = [
    path('diagnosis/', predict_diagnosis, name='predict_diagnosis'),
    path('scrape-google-news/', scrape_google_news, name='scrape_google_news'),
]
