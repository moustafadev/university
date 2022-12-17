USE ShopDB;

CREATE TABLE Departments
(DeptID INT PRIMARY KEY CHECK (DeptID >= 1 AND DeptID <=10),
DeptName NVARCHAR(50) NOT NULL);

INSERT INTO Departments (DeptID, DeptName)
SELECT DeptID, '' FROM Goods GROUP BY DeptID;

SELECT * FROM Departments, Goods;

SELECT * FROM Departments, Goods WHERE Departments.DeptID = Goods.DeptID;

SELECT * FROM Departments INNER JOIN Goods ON Departments.DeptID = Goods.DeptID;

INSERT INTO Departments VALUES (4, N'Молочный');

SELECT * FROM Departments LEFT OUTER JOIN Goods ON Departments.DeptID =
Goods.DeptID;

INSERT INTO Goods VALUES (8, N'колбаса', N'Сосновоборская', 50, 130);

SELECT * FROM Departments RIGHT OUTER JOIN Goods ON Departments.DeptID =
Goods.DeptID;

SELECT * FROM Departments FULL OUTER JOIN Goods ON Departments.DeptID =
Goods.DeptID;

SELECT *
FROM Departments FULL OUTER JOIN Goods ON Departments.DeptID = Goods.DeptID
EXCEPT
SELECT *
FROM Departments, Goods;

SELECT DISTINCT Departments.DeptID, DeptName
FROM Goods LEFT OUTER JOIN Departments
ON Goods.DeptID = Departments.DeptID
WHERE (Goods.GName IS NOT NULL AND Departments.DeptName IS NOT NULL);


SELECT DISTINCT Departments.DeptID, DeptName
FROM Departments, Goods
WHERE Departments.DeptID IN (
SELECT Goods.DeptID
FROM Departments
WHERE (Goods.GName IS NOT NULL AND Goods.DeptID = Departments.DeptID));

SELECT DISTINCT Departments.DeptID, DeptName;

SELECT DISTINCT Departments.DeptID, DeptName
FROM Departments, Goods
WHERE Departments.DeptID = ANY (
SELECT Goods.DeptID
FROM Departments
WHERE (Goods.GName IS NOT NULL AND Goods.DeptID = Departments.DeptID));


SELECT Goods.DeptID, MAX(Departments.DeptName) AS DeptName, SUM(Goods.Price *
Goods.GCount) AS SumCost
FROM Departments LEFT OUTER JOIN Goods
ON Departments.DeptID = Goods.DeptID
WHERE (Goods.DeptID IS NOT NULL)
GROUP BY Goods.DeptID;


SELECT TOP 1 Goods.DeptID, SUM(Goods.Price * Goods.GCount) AS SumCost,
MAX(Departments.DeptName) AS DeptName
FROM Departments LEFT OUTER JOIN Goods
ON Departments.DeptID = Goods.DeptID
WHERE (Goods.DeptID IS NOT NULL)
GROUP BY Goods.DeptID
ORDER BY SumCost DESC;

SELECT TOP 2 Goods.DeptID, MAX(Departments.DeptName) AS DeptName, SUM(Goods.Price
* Goods.GCount) AS SumCost
FROM Departments LEFT OUTER JOIN Goods
ON Departments.DeptID = Goods.DeptID
WHERE (Goods.DeptID IS NOT NULL)
GROUP BY Goods.DeptID
ORDER BY SumCost DESC;


SELECT Goods.GoodID, MAX(Goods.GName) AS GName, MAX(Goods.Descr) AS Descr,
MAX((Goods.Price * Goods.GCount)/CA.CostAll) * 100 AS Percents
FROM Goods, (SELECT DeptID,sum(Goods.Price * Goods.GCount) AS CostALL FROM Goods
GROUP BY Goods.DeptID) AS CA
WHERE Goods.DeptID = CA.DeptID
GROUP BY Goods.GoodID;

UPDATE Goods SET Goods.Price = Goods.Price + ReturnsAVG.Average
FROM (SELECT AVG(Goods.Price)/10 AS Average FROM Goods) AS ReturnsAVG;

CREATE TABLE Discount(
DeptID INT NOT NULL DEFAULT 1 CHECK (DeptID >= 1 AND DeptID <= 10),
GoodID INT NOT NULL PRIMARY KEY,
GName VARCHAR(20) NOT NULL,
Descr VARCHAR(50) NULL,
Price SMALLMONEY NOT NULL CHECK (Price > 0),
GCount INT NOT NULL CHECK (GCount > 0),
GDiscount SMALLMONEY DEFAULT NULL
UNIQUE (GName,Descr)
);

INSERT INTO Discount (DeptID, GoodID, GName, Descr, Price, GCount)
SELECT Goods.DeptID, Goods.GoodID ,Goods.GName, Goods.Descr, Goods.Price,
Goods.GCount FROM Goods;

UPDATE Discount SET GDiscount = Price/5 WHERE (Discount.Price < 10) ;
UPDATE Discount SET GDiscount = Price/10 WHERE (Discount.Price >= 10) AND
(Discount.Price <= 50);
UPDATE Discount SET GDiscount = Price/20 WHERE (Discount.Price > 50) ;

INSERT INTO Departments
VALUES (5, 'Мебельный')
ALTER TABLE Goods
ADD FOREIGN KEY (DeptID) REFERENCES Departments(DeptID);

