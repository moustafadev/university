CREATE VIEW view_1
AS
SELECT ID_author, first_name, last_name, year_of_birth FROM Authors
WHERE Id_Books = 1;
GO

SELECT MIN(year_of_birth) AS 'Minimal_birthday' FROM view_1;

SELECT MIN(year_of_birth) AS 'Minimal_birthday' FROM Authors;

-- drop VIEW view_1

ALTER VIEW view_1
AS
SELECT ID_author, first_name, last_name, year_of_birth 
FROM Authors
WHERE Id_Books = 5;
GO



INSERT INTO view_1
VALUES(11,'Petr Ivanov', 'beb', GETDATE());

UPDATE view_1 SET Id_Books = 2 WHERE ID_author = 1112;


CREATE VIEW view_2
AS SELECT ID_author, first_name, last_name, year_of_birth ,Id_Books
FROM Authors
WHERE Id_Books = 1 WITH CHECK OPTION;
GO

SELECT *
FROM view_2
ORDER BY year_of_birth;

INSERT INTO view_2
VALUES(1222,'Petr Ivanov', 'dadads', GETDATE(), 1);

UPDATE view_2 SET Id_Books = 1 WHERE ID_author = 1122;

DELETE FROM view_2 WHERE ID_author = 5;
GO

CREATE VIEW view_3 AS
SELECT Books.book_name, Orders.OrderID FROM Books, Orders;
Go

SELECT * FROM view_3
GO

CREATE VIEW view_4
AS SELECT book_name, OrderID  FROM view_3
WHERE OrderID = 1;
GO

--تقوم الوظييفه بالبحث في قاعده البيانات وتاتي بالبيانات المتكرره بالاسم
CREATE VIEW view_5(Cost, countCost)
AS SELECT first_name, COUNT(*) FROM Customers
GROUP BY first_name;
GO

CREATE VIEW view_6
AS SELECT ID_book, book_name, year_of_publication FROM Books
WHERE ID_book BETWEEN 2 AND 5
WITH CHECK OPTION;
GO

--يقوم باظهار جميع الviews الموجوده في قاعده البيانات
SELECT * FROM sys.views


EXEC sp_helptext 'view_6'

SELECT DISTINCT OBJECT_NAME(object_id) AS Name FROM sys.sql_dependencies
WHERE referenced_major_id= OBJECT_ID(N'Books');

SELECT DISTINCT OBJECT_NAME(object_id) AS Name FROM sys.sql_dependencies
WHERE referenced_major_id= OBJECT_ID(N'Authors');

