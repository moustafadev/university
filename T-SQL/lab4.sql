


--1)использование базы данных Shop
USE ShopDB
GO
--2)
--получить информацию об индексах для таблицы Departments
--الحصول على معلومات الفهرس لجدول الأقسام
EXEC sp_helpindex [Departments]
--3)
--получить информацию об индексах для таблицы Goods
--الحصول على معلومات حول فهارس السلع الجدول
EXEC sp_helpindex [Goods]
--4)
--получить информацию об индексах для таблицы Discount
--الحصول على معلومات حول فهارس الجدول الخصم
EXEC sp_helpindex [Discount]
--5)
--Вычисление суммарной стоимости проданного товара для каждого отдела 
--حساب التكلفة الإجمالية للبضائع المباعة لكل قسم
SELECT Departments.DeptID, Departments.DeptName, SUM(Goods.Price * Goods.GCount) AS 'Sum' 
FROM Departments INNER JOIN Goods ON Goods.DeptID = Departments.DeptId
GROUP BY Departments.DeptID, Departments.DeptName
ORDER BY Departments.DeptID;
--6)
--Выполнение внутреннего соединения таблиц Departments и Goods по столбцу DeptID, упорядочение по количеству
--إجراء صلة داخلية في جداول الأقسام والبضائع في عمود DeptID ، الترتيب حسب العدد
SELECT * FROM Goods INNER JOIN Departments ON Goods.DeptID = Departments.DeptId
ORDER BY Goods.GCount;
--7)
--Упорядочение по стоимости
--اطلب حسب التكلفة
SELECT * FROM Goods
ORDER BY Price
--8)
--Выполнение левого внешнего соединения таблиц Departments и Goods по столбцу DeptID, упорядочение по DeptID
--تنفيذ صلة خارجية يسرى في جداول الأقسام والبضائع في عمود DeptID ، الترتيب على DeptID
SELECT * FROM Departments LEFT JOIN Goods ON Goods.DeptID = Departments.DeptId
ORDER BY Price
--9)
--Выборка по товаров в количестве больше 80
--عينة من البضائع بكمية تزيد عن 80
SELECT * FROM Goods 
WHERE GCount > 80
ORDER BY GCount desc
--10)
--некластеризованный убывающий индекс по столбцу GCount
--الفهرس التنازلي غير العنقودي على عمود GCount
CREATE NONCLUSTERED INDEX [AK_Goods_GCount]
ON [Goods] ([GCount] DESC)
--11)
--некластеризованный возрастающий индекс по столбцу Price
--مؤشر متزايد غير متفاوت في عمود "السعر"
CREATE NONCLUSTERED INDEX [AK_Goods_Price]
ON [Goods] (Price ASC)