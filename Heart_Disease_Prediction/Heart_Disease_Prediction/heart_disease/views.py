from gettext import npgettext
from django.shortcuts import render

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
import lightgbm as lgb
from xgboost import XGBClassifier
from sklearn.metrics import confusion_matrix
import joblib
from warnings import simplefilter
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import requests
from bs4 import BeautifulSoup
from .models import NewsArticle
from urllib.parse import urljoin
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
import matplotlib.pyplot as plt
import numpy as np

simplefilter(action='ignore', category=FutureWarning)

df = pd.read_csv('/Users/macbookair/Heart_Disease_Prediction/Heart_Disease_Prediction/heart_disease/cleveland.csv', header=None)
df.columns = ['age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg', 'thalach', 'exang',
              'oldpeak', 'slope', 'ca', 'thal', 'target']

df.isnull().sum()
df['target'] = df.target.map({0: 0, 1: 1, 2: 1, 3: 1, 4: 1})
df['sex'] = df.sex.map({0: 'female', 1: 'male'})
df['thal'] = df.thal.fillna(df.thal.mean())
df['ca'] = df.ca.fillna(df.ca.mean())
df['sex'] = df.sex.map({'female': 0, 'male': 1})
df.replace({'?': 0}, inplace=True)
X = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# SVM
svm_classifier = SVC(kernel='rbf')
svm_classifier.fit(X_train, y_train)

# Naive Bayes
nb_classifier = GaussianNB()
nb_classifier.fit(X_train, y_train)

# Logistic Regression
lr_classifier = LogisticRegression()
lr_classifier.fit(X_train, y_train)

# Decision Tree
dt_classifier = DecisionTreeClassifier()
dt_classifier.fit(X_train, y_train)

# Random Forest
rf_classifier = RandomForestClassifier(n_estimators=10)
rf_classifier.fit(X_train, y_train)

# LightGBM
d_train = lgb.Dataset(X_train, label=y_train)
params = {}
lgb_classifier = lgb.train(params, d_train, 100)

# XGBoost
xg_classifier = XGBClassifier()
xg_classifier.fit(X_train, y_train)


#NNA
model = Sequential()
model.add(Dense(128, activation='relu', input_shape=(X_train.shape[1],)))
model.add(Dropout(0.2))
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(1, activation='sigmoid'))
model.compile(optimizer='adam',
              loss='binary_crossentropy', 
              metrics=['accuracy'])
model.fit(X_train, y_train, epochs=100, batch_size=32)
score = model.evaluate(X_test, y_test)
weights = model.layers[0].get_weights()[0]

# plt.plot(weights,linewidth=2)
# plt.show()

def sigmoid(x):
    return 1 / (1 + npgettext.exp(-x))

# Генерация значений для оси x
x_values = np.linspace(-5, 5, 100).reshape(-1, 1)  # Преобразование в столбец для совместимости с моделью

# Используем обученные веса и смещения
weights = model.layers[0].get_weights()[0]
biases = model.layers[0].get_weights()[1]

# Вычисляем выход нейронной сети (первого слоя) без применения функции активации
network_output = np.dot(x_values, weights) + biases

# Применяем сигмоидную функцию к выходу нейронной сети
sigmoid_output = sigmoid(network_output)

# Построение графика
plt.plot(x_values, sigmoid_output, label='Sigmoid Output', linewidth=2)
plt.title('Sigmoid Output of Neural Network')
plt.xlabel('Input')
plt.ylabel('Sigmoid(Output)')
plt.axhline(0.5, color='red', linestyle='--', label='Threshold = 0.5')
plt.legend()
plt.grid(True)
plt.show()

@csrf_exempt
def predict_diagnosis(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            if 'age' not in data or 'sex' not in data or 'cp' not in data:
                return JsonResponse({"error": "Missing required fields in input data"}, status=400)
            
            input_data = pd.DataFrame([data])
            
            # neural_net_pred = svm_classifier.predict(input_data_scaled)
            input_data_scaled = scaler.transform(input_data)
            svm_pred = svm_classifier.predict(input_data_scaled)
            nn_pred = model.predict(input_data_scaled)
            nb_pred = nb_classifier.predict(input_data_scaled)
            lr_pred = lr_classifier.predict(input_data_scaled)
            dt_pred = dt_classifier.predict(input_data_scaled)
            rf_pred = rf_classifier.predict(input_data_scaled)

            lgb_pred = (lgb_classifier.predict(input_data_scaled) >= 0.5).astype(int)
            xg_pred = (xg_classifier.predict(input_data_scaled) >= 0.5).astype(int)
            svm_accuracy = accuracy_score(y_test, svm_classifier.predict(X_test))
            nb_accuracy = accuracy_score(y_test, nb_classifier.predict(X_test))
            lr_accuracy = accuracy_score(y_test, lr_classifier.predict(X_test))
            dt_accuracy = accuracy_score(y_test, dt_classifier.predict(X_test))
            rf_accuracy = accuracy_score(y_test, rf_classifier.predict(X_test))
            lgb_accuracy = accuracy_score(y_test, (lgb_classifier.predict(X_test) >= 0.5).astype(int))
            xg_accuracy = accuracy_score(y_test, (xg_classifier.predict(X_test) >= 0.5).astype(int))

            response_data = {
                'svm_diagnosis': 'positive' if svm_pred[0] == 1 else 'negative',
                'nb_diagnosis': 'positive' if nb_pred[0] == 1 else 'negative',
                'lr_diagnosis': 'positive' if lr_pred[0] == 1 else 'negative',
                'dt_diagnosis': 'positive' if dt_pred[0] == 1 else 'negative',
                'rf_diagnosis': 'positive' if rf_pred[0] == 1 else 'negative',
                'lgb_diagnosis': 'positive' if lgb_pred[0] == 1 else 'negative',
                'xg_diagnosis': 'positive' if xg_pred[0] == 1 else 'negative',
                'NNa_diagnosis': 'positive' if nn_pred[0] == 1 else 'negative',
                'svm_accuracy': svm_accuracy,
                'nb_accuracy': nb_accuracy,
                'lr_accuracy': lr_accuracy,
                'dt_accuracy': dt_accuracy,
                'rf_accuracy': rf_accuracy,
                'lgb_accuracy': lgb_accuracy,
                'xg_accuracy': xg_accuracy,
                'NNA_accuracy': score[1],
            }
            print(JsonResponse(response_data))

            return JsonResponse(response_data)
        except json.JSONDecodeError as e:
            return JsonResponse({"error": "Invalid JSON format"}, status=400)
    else:
        return JsonResponse({"error": "Only POST requests are allowed"}, status=405)




@csrf_exempt
def scrape_google_news(request):
    if request.method == 'GET':
        try:
            search_query = request.GET.get('search_query', '')
            # Fetch Google News results
            google_news_url = f'https://news.google.com/search?q={search_query}&hl=en-US&gl=US&ceid=US%3Aen'
            response = requests.get(google_news_url)
            
            soup = BeautifulSoup(response.text, 'html.parser')
            # Extract news articles
            articles = soup.find_all('h3', class_='ipQwMb ekueJc RD0gLb')
            news_list = []
           
            for article in articles:
                title = article.text
                link = article.a['href']
                description = article.find_next('span', class_='xBbh9')
                
                image_element = article.find_next('img', class_='tvs3Id QwxBBf')
                image_url = image_element['src'] if image_element else ''
                news_obj, created = NewsArticle.objects.get_or_create(
                    title=title,
                    link=link,
                    description=description
                    
                )
                base_url = 'https://news.google.com'
                link_with_url = urljoin(base_url, link)
                news_list.append({
                    'title':title if title else '',
                    'link': link_with_url if link_with_url else '',
                    'image_url':  image_url if image_url else '',
                    'description': description if description else ''
                })

            return JsonResponse({'success': True, 'news': news_list})
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)}, status=500)
    else:
        return JsonResponse({'error': 'Only GET requests are allowed'}, status=405)
