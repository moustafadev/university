

-------value-------Метод value используется, чтобы возвратить одно значение из документа XML.
DECLARE @myDoc XML 
SET @myDoc = '<Books>
<Book Id="1" Aurhor_Id="1"> <Description>
<Name>Pesto</Name> <Category>For breakfast</Category> <Letters>235</Letters> <Cost>1000.00</Cost> </Description>
</Book>
<Book Id="2" Aurhor_Id="2"> <Description>
<Name>mostafa</Name> <Category>For breakfast</Category> <Letters>235</Letters> <Cost>10030.02</Cost> </Description>
</Book>
</Books>'
DECLARE @Cost varchar
SET @Cost = @myDoc.value('(/Books/Book/Description/Cost)[2]', 'varchar(50)') SELECT @Cost

SET @Cost = @myDoc.value('(/Books/Book/Description/Cost)[2]', 'decimal(10,2)') SELECT @Cost -- extract a single scalar value


-------query-------Метод query используется, чтобы извлечь XML-данные из типа данных xml. XML- документ, полученный методом query, определяется по выражению XQuery, которое является параметром.
SELECT @myDoc.query('/Books/Book/Description')-- extract one or more elements or attributes


-------exist-------Метод exist используется для определения того, существует ли указанный узел в XML документе
DECLARE @myDoc XML 
SET @myDoc = '<Books>
<Book Id="1" Aurhor_Id="1"> <Description>
<Name>Pesto or Mesto</Name> <Category>For breakfast</Category>
<Letters>235</Letters> <Cost>1000.00</Cost> </Description>
</Book>
</Books>'
IF @myDoc.exist('/Books/Book[(@Id cast as xs:int?) eq xs:int("1")]') = 1
   SELECT 'The Product element contains a Name element.'
ELSE
   SELECT 'The Product element does not contain a Name element.'

-- DECLARE @tmp BIT
-- SET @tmp = @myDoc.exist('/Books/Book[(@Id cast as xs:int?) eq xs:int("2")]') SELECT @tmp


-------modify-------Mетод modify использует три расширения для языковой спецификации XQuery: insert, replace, и delete. Эти расширения упоминаются как XML DML.
DECLARE @data XML
SET @data =
'<Books Id="1">
<Book Id="1" Aurhor_Name="Vasyan" Names="ave" Category="1"/> <Book Id="2" Aurhor_Name="Boryan" Names="nn" Category="3"/> </Books>';
SET @data.modify('insert if (count(/Books/Book) <= 3) then element Book {"adadadasd"} else () as last into (/Books[@Id=1])[1]'); SELECT @data
SET @data.modify('insert if (count(/Books/Book) <= 3) then element Book {"adadadasd"} else () as last into (/Books[@Id=1])[1]'); SELECT @data

--SET @data.modify('insert if (count(/Books/Book) <= 3) then element Book {"adadadasd"} else () as last into (/Books[@Id=1])[1]')
--SET @data.modify('delete if (count(/Books/Book) <= 3) then /Books[@Id=1]/Book[@Id=1] else ()');
-- SET @data.modify('replace value of (/Books[@Id=1]/Book[@Id=1]/@Names)[1] with "mostafa"'); SELECT @data

-------nodes-------
DECLARE @data XML
SET @data =
'<Books Id="1">
<Book Id="1" Aurhor_Name="Vasyan" Names="ave" Category="1"/> 
<Book Id="2" Aurhor_Name="Boryan" Names="adads" Category="3"/> 
</Books>';
SELECT T.book.query('.') AS results FROM @data.nodes('/Books/Book') T(book)