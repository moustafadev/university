# استيراد المكتبات اللازمة
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# تحميل مجموعة البيانات
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"
names = ["age", "sex", "cp", "trestbps", "chol", "fbs", "restecg", "thalach", "exang", "oldpeak", "slope", "ca", "thal", "target"]
data = pd.read_csv(url, names=names, na_values='?')

# استبدال القيم المفقودة بالمتوسط
data.fillna(data.mean(), inplace=True)

# تقسيم البيانات إلى متغيرات التنبؤ والهدف
X = data.drop("target", axis=1)
y = data["target"]

# تقسيم البيانات إلى مجموعة تدريب ومجموعة اختبار
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# إنشاء وتدريب نموذج التنبؤ (Random Forest)
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# التنبؤ باستخدام النموذج
y_pred = model.predict(X_test)

# حساب الدقة
accuracy = accuracy_score(y_test, y_pred)
print(f"الدقة: {accuracy * 100:.2f}%")
