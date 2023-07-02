-- USE shop_book

-- select * from Users

-- select * from Positions

-- alter table Users drop column XML_column 

--insert
-- بعد تشغيل ال تارجير يتم زياده التوتل ١٠ في كل مره يقوم بعمل اضافه
-- create trigger insertingTrigger
-- on Orders
-- after insert
-- as update 
-- set TotalAmount = TotalAmount + 10 



-- CREATE TRIGGER update_book_count
-- ON Books_in_use
-- AFTER INSERT
-- AS
-- BEGIN
--     UPDATE Books SET book_count = book_count - 1 WHERE ID_book in (SELECT ID_book FROM inserted);
-- END;

-- SELECT * from Books

-- INSERT INTO Books_in_use (ID_book, ID_customers, date_of_issue, return_date)
-- VALUES (3, 1, '2023-06-09', '2023-06-16');

-- SELECT * from Books


-- SELECT book_count FROM Books WHERE ID_book = 1;
-- CREATE TRIGGER trigger1 
-- ON OrderDate 
-- FOR INSERT
-- AS 

-- --INSERT INTO OrderDate
-- --SELECT FROM TABLE

--       IF @@ROWCOUNT = 0
--          RETURN

-- SET NOCOUNT ON

-- UPDATE 

-- SELECT * from category

-- insert into category values (8,"1",1)
-- SELECT * from category

-- DROP TRIGGER insertingTr
-- --delete

-- create trigger deleteTrigger
-- on Orders after delete
-- as update Orders
-- set TotalAmount = TotalAmount -10

-- delete from Orders where TotalAmount = 9

-- --update
-- create trigger updatingTrigger
-- on Orders
-- after update
-- as update Orders
-- set CustomerID = 1

-- update Orders set count_books = 2 where TotalAmount = 100

-- --instead of

create trigger insteadOfTrigger
on Orders instead of update as
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, count_books)
VALUES (101, 11, '1999', 90, 3)

Select COUNT(*) FROM Orders
update Orders set OrderDate = '2000-01-01'
Select COUNT(*) FROM Orders
