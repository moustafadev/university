


/*Создайте БД ShopDB со всеми параметрами по умолчанию.*/
CREATE DATABASE ShopDB;


/*Создайте таблицу Goods (товары) в БД ShopDB со следующими свойствами:*/
CREATE TABLE Goods(
    DeptID INT Not NULL ,
    GoodID INT IDENTITY (10, 10) PRIMARY KEY,
    GName NVARCHAR(20) NOT NULL,
    Descr NVARCHAR(20) NULL,
    Price SMALLMONEY NOT NULL,
    GCount INT NOT NULL,
    CONSTRAINT DeptID_chk CHECK(DeptID BETWEEN 1 AND 10),/*((DeptID >= 1 AND DeptID <=10),)*/
    CONSTRAINT Price_chk CHECK(Price>0),
    CONSTRAINT GCount_chk CHECK(GCount>0) ,
    CONSTRAINT Goods_uq UNIQUE(GName,Descr)
);

/*Заполните таблицу Goods (товары) в БД ShopDB */
INSERT INTO Goods VALUES
(1,N'ручка',N'шариковая', 2, 100),
(1,N'ручка',N'гелевая', 10, 50),
(1,N'карандаш',N'простой', 5, 200),
(1,N'карандаш',N'механический', 10, 30),
(2,N'мыло',N'хозяйственное', 6, 200),
(2,N'мыло',N'детское', 7, 150),
(2,N'шампунь',N'"Чистая Линия"', 50, 7);

/*Пользуясь командой INSERT, добавьте в таблицу Goods два новых товара:*/


ALTER TABLE Goods
ADD CONSTRAINT df_Goods 
DEFAULT 4 FOR DeptID;

INSERT INTO Goods VALUES
(3, N'хлеб', N'сельский', 20, 30),
(DEFAULT, N'ручка', NULL, 15, 40);

/*Пользуясь командой DELETE, удалите из таблицы Goods те товары, у которых не задано описание (т.е. Descr принимает значение null).*/
DELETE FROM Goods WHERE Descr IS NULL;


/*Пользуясь командой UPDATE, обновите таблицу Goods – увеличьте цены на все товары на 10%*/
UPDATE Goods SET Price = Price * 1.1;

/*Пользуясь командой SELECT, выведите таблицу Goo*/
SELECT * FROM Goods;
/*Выведите все товары (их номер, имя и описание), которые продаются в первом
отделе */

SELECT GoodID, GName, Descr FROM Goods WHERE DeptID = 1;

/*Выведите все сведения о товарах в ценовом диапазоне от 10 до 30 рублей,
используя предикат BETWEEN */

SELECT * FROM Goods WHERE Price BETWEEN 10 AND 30;

/*Выведите все сведения о товарах первого и третьего отдела, используя предикат
IN.*/
SELECT * FROM Goods WHERE DeptID IN (1, 3) ;

/* Выведите все сведения о товарах, имя которых начинается на ‘р’, используя
предикат LIKE */

SELECT * FROM Goods WHERE GName LIKE N'р%' ;
/*Выведите все сведения о товарах, в имени которых встречается символ ‘_’,
используя предикат LIKE.*/

SELECT * FROM Goods WHERE GName LIKE N'_а%' ESCAPE '#' ;

/*Выведите наименования всех товаров.*/

SELECT GName FROM Goods;

/*Выведите наименования всех товаров без повторений.*/
SELECT GName FROM Goods GROUP BY GName;
/*Выведите все сведения о товарах плюс вычисляемый столбец – стоимость каждого товара (цена * количество).*/
SELECT *, Price * GCount AS Cost FROM Goods;
/*Выведите минимальную, среднюю, максимальную цену по всем товарам.*/
SELECT MIN(Price) AS MinPrice, AVG(Price) AS AvPrice, MAX(Price) AS MaxPrice FROM
Goods;
/*Выведите количество наименований товаров, продающихся в первом отделе.*/
SELECT COUNT(DISTINCT GName) AS NameCount FROM Goods WHERE DeptID = 1;
/*Выведите количество товаров, для которых задано описание (Descr не null).*/
SELECT COUNT(GoodID) AS GoodsCount FROM Goods WHERE Descr IS NOT NULL;
/*Выведите суммарную стоимость товаров по второму отделу.*/
SELECT SUM(Price * GCount) AS SumCost FROM Goods WHERE DeptID = 2;
/*Выведите все товары, упорядочивая по именам.*/
SELECT * FROM Goods ORDER BY GName;
/*Выведите все товары, упорядочивая по отделам и по убыванию цены.*/
SELECT * FROM Goods ORDER BY DeptID, Price DESC;
/*Вычислите стоимость проданного товара по каждому отделу.*/
SELECT DeptID, SUM(Price * GCount) AS TotalCost FROM Goods GROUP BY DeptID;
/*Вычислите среднюю цену только по тем товарам, цена которых превышает 9 рублей*/
SELECT AVG(Price) AS AVG9Price FROM Goods WHERE Price > 9;
/* Вычислите максимальную цену по каждому наименованию товара.*/
SELECT DISTINCT GName, MAX(Price) FROM Goods GROUP BY GName;
/* Выведите номера отделов, где продается более двух наименований товаров.*/
SELECT DISTINCT DeptID FROM Goods GROUP BY DeptID HAVING COUNT(DISTINCT GName) >2;
/**/
SELECT * From Goods;

UPDATE Goods SET Price = Price*1.15;

SELECT MIN(Price) AS MinPrice, AVG(Price) AS AvPrice, MAX(Price) AS MaxPrice FROM Goods;


INSERT INTO Goods VALUES
(1,N'shampo',N'детское',10,100),
(1,N'chebs',NULL,10,100),
(1,N'вода',N'',10,100),
(1,N'мащена',N'',10,70);