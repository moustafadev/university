
DECLARE @tmp xml =
'<Books>
<Book Id="1" Aurhor_Name="Vasyan" Names="ave" ID_author="1"/>
<Book Id="2" Aurhor_Name="Boryan" Names="adads" ID_author="3"/>
</Books>';
DECLARE @h int;
EXECUTE sp_xml_preparedocument @h OUTPUT, @tmp, '';
SELECT * FROM OPENXML(@h, '/Books/Book', 1) WITH (Aurhor_Name nvarchar(39),
Names nvarchar(30), ID_author int);



DECLARE @tmp1 xml =
'<Books>
<Book Id="1" Aurhor_Name="Vasyan" Names="ave" ID_author="1"/> 
<Book Id="2" Aurhor_Name="Boryan" Names="adads" ID_author="3"/>
</Books>';
DECLARE @h1 int;
EXECUTE sp_xml_preparedocument @h1 OUTPUT, @tmp1, '';
SELECT *
FROM OPENXML(@h1, '/Books/Book', 1)
WITH (Book_ID int './@Id', Aurhor_Name nvarchar(30) 
'./@Aurhor_Name', ID_author int './@ID_author', Names nvarchar(30)
'./@Names');
