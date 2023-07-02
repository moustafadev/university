CREATE TABLE Orders (
  OrderID int PRIMARY KEY,
  CustomerID int,
  OrderDate date,
  TotalAmount decimal(10,2)
);

INSERT INTO Orders VALUES (1, 1, '2023-05-01', 100.00);
INSERT INTO Orders VALUES (2, 1, '2023-05-02', 50.00);
INSERT INTO Orders VALUES (3, 2, '2023-05-03', 75.00);
INSERT INTO Orders VALUES (4, 3, '2023-05-04', 200.00);


-- Определить, какие индексы уже созданы в собственной 
-- БД. При этом следует использовать разные способы получения информации об индексах.
SELECT name, type_desc, is_unique, is_primary_key
FROM sys.indexes
WHERE object_id = OBJECT_ID('Customers');

-- Сформулировать 5-6 сложных запросов SELECT к собственной БД,
--  содержащих соединения таблиц, сортировку, группировку данных.


CREATE INDEX idx_Customers_ID_customers ON Customers(ID_customers);
CREATE INDEX idx_Orders_CustomerID ON Orders(CustomerID);
CREATE INDEX idx_Orders_TotalAmount ON Orders(TotalAmount);
-- Запрос 1: Получить общую сумму всех заказов каждого клиента

SELECT first_name, last_name, SUM(o.TotalAmount) as TotalAmount
FROM Customers c
JOIN Orders o ON ID_customers = o.CustomerID
GROUP BY first_name, last_name



CREATE NONCLUSTERED INDEX BOOKNAME
ON Books(book_name)

CREATE UNIQUE NONCLUSTERED INDEX Book_Name ON BOOKS (book_name)
WITH (FILLFACTOR = 65, PAD_INDEX = ON)


CREATE UNIQUE INDEX idx_book_title ON Customers (phone_number);

-- CREATE UNIQUE NONCLUSTERED INDEX [] ON [Customers] ( [LoginID] ASC);

CREATE NONCLUSTERED INDEX AK_Customers_OrderId on Customers

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2023-05-01' AND '2023-05-01';

SELECT *
FROM Orders WITH (INDEX(idx_OrderDate))
WHERE OrderDate BETWEEN '2022-01-01' AND '2022-12-31';

-- Запрос 2: получить 5 лучших клиентов с наибольшей суммой заказов.
SELECT TOP 5 c.first_name, c.last_name, SUM(o.TotalAmount) as TotalAmount
FROM Customers c
JOIN Orders o ON c.ID_customers = o.CustomerID
GROUP BY c.first_name, c.last_name
ORDER BY TotalAmount DESC

-- Запрос 3: получить количество заказов для каждого клиента, отсортированное по количеству заказов
SELECT c.first_name, c.last_name, COUNT(o.OrderID) as OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.ID_customers = o.CustomerID
GROUP BY c.first_name, c.last_name
ORDER BY OrderCount DESC

-- Запрос 4: получить среднюю сумму заказа для каждого клиента, отсортированную по средней сумме заказа.
SELECT c.first_name, c.last_name, AVG(o.TotalAmount) as AverageOrderTotal
FROM Customers c
LEFT JOIN Orders o ON c.ID_customers = o.CustomerID
GROUP BY c.first_name, c.last_name
ORDER BY AverageOrderTotal DESC

-- Запрос 5: получить первые 3 месяца с наибольшей общей суммой заказа
SELECT YEAR(OrderDate) as Year, MONTH(OrderDate) as Month, SUM(TotalAmount) as TotalAmount
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY TotalAmount DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY

CREATE INDEX idx_OrderDate ON Orders(OrderDate);

SELECT YEAR(OrderDate) as Year, MONTH(OrderDate) as Month, SUM(TotalAmount) as TotalAmount
FROM Orders WITH (INDEX(idx_OrderDate))
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY TotalAmount DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;



