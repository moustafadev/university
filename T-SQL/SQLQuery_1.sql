--Создание простой хранимой процедуры
CREATE PROC book_cat AS
SELECT book_name, category_id FROM Books GO

EXEC book_cat


GO
ALTER PROCEDURE book_cat @category_id INT = 1
AS
IF (@category_id < 1 or @category_id > 10) BEGIN
PRINT 'There is no such category!'
RETURN
END
SELECT book_name as 'Book name', category_id AS 'product count' FROM Books WHERE category_id = @category_id


--Вызов параметризованной процедуры по позиции
EXEC book_cat 2
EXEC book_cat @category_id = 1


--Удаление ранее созданной хранимой процедуры
DROP PROC book_cat

--Создание процедуры с выходными параметрами и обработка ошибок
GO
CREATE PROC add_book
@ID_book int ,@book_name varchar(100), @updated_at varchar(100), @category_id int, @year_of_publication int, @ID_subject int OUTPUT
AS
begin try
INSERT INTO Books(ID_book,book_name, updated_at, category_id, year_of_publication) VALUES (@ID_book,@book_name, @updated_at, @category_id, @year_of_publication) SET @ID_subject = SCOPE_IDENTITY()
end try
begin catch
SELECT ERROR_NUMBER() ErrorNumber, ERROR_MESSAGE() [Message]
end catch
GO

-- DROP PROC add_book

DECLARE @ID_subject int
EXEC add_book 166,'холодильasddasнjhgик', "2023", 1 , "1955", @ID_subject OUTPUT SELECT @ID_subject as '@ID_subject'

--Вызов ранее созданной процедуры без ошибки
DECLARE @book_id int
EXEC add_book 'холодильasddasнjhgик', 1, 2023, 1 , 1955, @ID_book OUTPUT SELECT @book_id as 'book_idD'
GO

ALTER TABLE Books ID_subject int NULL;



