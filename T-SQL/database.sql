create DATABASE shop_book

CREATE TABLE Subject
(
    ID_subject INT NOT NULL Primary key,
    subject VARCHAR(100) NOT NULL
);


CREATE TABLE Books
(
    ID_book INT NOT NULL Primary key,
    ID_subject INT NOT NULL,
    book_name NVARCHAR(100) NOT NULL,
    year_of_publication NVARCHAR(4) NOT NULL,
    FOREIGN KEY (ID_subject) REFERENCES Subject(ID_subject)
);

CREATE TABLE Authors
(
    ID_author INT NOT NULL Primary key,
    last_name VARCHAR(35) NOT NULL,
    first_name VARCHAR(35) NOT NULL,
    year_of_birth VARCHAR(4) NOT NULL
);

CREATE TABLE Customers
(
    ID_customers INT NOT NULL Primary key,
    last_name VARCHAR(35) NOT NULL,
    first_name VARCHAR(35) NOT NULL,
    year_of_birth VARCHAR(4) NOT NULL,
    phone_number INT NOT NULL,
    home_address VARCHAR(35) NOT NULL
);


CREATE TABLE Books_in_use
(
    ID_book INT NOT NULL,
    ID_customers INT NOT NULL,
    date_of_issue DATE NOT NULL,
    return_date DATE NOT NULL,
    FOREIGN KEY (ID_book) REFERENCES Books(ID_book),
    FOREIGN KEY (ID_customers) REFERENCES Customers(ID_customers),
    CONSTRAINT UC_Books_in_use UNIQUE (ID_book,ID_customers)
);

CREATE TABLE Author_subject
(
    ID_author INT NOT NULL,
    ID_subject INT NOT NULL,
    FOREIGN KEY (ID_author) REFERENCES Authors(ID_author),
    FOREIGN KEY (ID_subject) REFERENCES Subject(ID_subject),
    CONSTRAINT UC_Author_subject UNIQUE (ID_author,ID_subject)
);
CREATE TABLE Book_author
(
    ID_book INT NOT NULL,
    ID_author INT NOT NULL,
    FOREIGN KEY (ID_book) REFERENCES Books(ID_book),
    FOREIGN KEY (ID_author) REFERENCES Authors(ID_author),
    CONSTRAINT UC_Book_author UNIQUE (ID_book,ID_author)
);


INSERT INTO Subject VALUES (1,N'Художественная литература');
INSERT INTO Subject VALUES (2,N'Книги для детей');
INSERT INTO Subject VALUES (3,N'Образование');
INSERT INTO Subject VALUES (4,N'Наука и техника');
INSERT INTO Subject VALUES (5,N'Биографии. Мемуары');
INSERT INTO Subject VALUES (6,N'Деловая литература');
INSERT INTO Subject VALUES (7,N'Красота. Здоровье. Спорт');
INSERT INTO Subject VALUES (8,N'Искусство');
INSERT INTO Subject VALUES (9,N'Психология');
INSERT INTO Subject VALUES (10,N'Философия и религия');


INSERT INTO Books VALUES (1,1,N'Мешок с костями','1850');
INSERT INTO Books VALUES (2,3,N'Ты - Художник!','1850');
INSERT INTO Books VALUES (3,5,N'Топаз','1850');
INSERT INTO Books VALUES (4,2,N'Конек-Горбунок','1850');
INSERT INTO Books VALUES (5,7,N'Введение в психоанализ','1850');
INSERT INTO Books VALUES (6,8,N'Я считаю по 7','1850');
INSERT INTO Books VALUES (7,6,N'Букварь','1850');
INSERT INTO Books VALUES (8,10,N'Охота на овец','1850');
INSERT INTO Books VALUES (9,4,N'Приключения английского языка','1850');
INSERT INTO Books VALUES (10,9,N'Мастер времени','1850');



INSERT INTO Authors VALUES (1,N'Кинг',N'Стивен',N'1947');
INSERT INTO Authors VALUES (2,N'Мураками',N'Рю',N'1952');
INSERT INTO Authors VALUES (3,N'Мураками',N'Харуки',N'1949');
INSERT INTO Authors VALUES (4,N'Ершов',N'Петр',N'1815');
INSERT INTO Authors VALUES (5,N'Слоун',N'Холли',N'1958');
INSERT INTO Authors VALUES (6,N'Емец',N'Дмитрий',N'1974');
INSERT INTO Authors VALUES (7,N'Кийосаки',N'Роберт',N'1947');
INSERT INTO Authors VALUES (8,N'Трейси',N'Брайан',N'1944');
INSERT INTO Authors VALUES (9,N'Маркс',N'Карл',N'1818');
INSERT INTO Authors VALUES (10,N'Бубновский',N'Сергей',N'1955');


INSERT INTO Customers VALUES 
(1,N'Петрова',N'Александра',N'1956-04-12','89106483957',N'ул. Заречная, д. 14, кв. 105');
INSERT INTO Customers VALUES 
(2,N'Соколов',N'Борис',N'1980-06-05','89053749065',N'ул. Сиреневая, д. 26, кв. 44');
INSERT INTO Customers VALUES 
(3,N'Петров',N'Борис',N'1992-11-22','89682759603',N'ул. Талсинская, д. 5, кв. 24');
INSERT INTO Customers VALUES 
(4,N'Давыденко',N'Юлия',N'1973-09-15','89266496530',N'ул. Заречная, д. 14, кв. 122');
INSERT INTO Customers VALUES 
(5,N'Греченко',N'Владислав',N'1968-01-30','89164285037',N'ул. Сиреневая, д. 22, кв. 44');
INSERT INTO Customers VALUES 
(6,N'Карпов',N'Марк',N'2000-07-17','89620374805',N'гул. Советская, д. 9, кв. 3');
INSERT INTO Customers VALUES 
(7,N'Иванов',N'Иван',N'1989-12-08','89290075393',N'ул. Широкая, д. 7, кв. 22');
INSERT INTO Customers VALUES 
(8,N'Тищук',N'Александра',N'1966-10-04','89288455733',N'ул. Светская, д. 16, кв. 57');
INSERT INTO Customers VALUES 
(9,N'Иванов',N'Иван',N'1977-02-24','89036620474',N'ул. Кирова, д. 10, кв. 64');


INSERT INTO Books_in_use VALUES (2,1,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (2,2,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (2,3,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (4,5,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (5,1,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (5,8,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (6,7,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (7,9,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (8,2,'2018-03-10','2018-03-20');
INSERT INTO Books_in_use VALUES (8,8,'2018-03-10','2018-03-20');

INSERT INTO Author_subject VALUES (1,1);
INSERT INTO Author_subject VALUES (2,1);
INSERT INTO Author_subject VALUES (3,1);
INSERT INTO Author_subject VALUES (4,2);
INSERT INTO Author_subject VALUES (5,2);
INSERT INTO Author_subject VALUES (6,2);
INSERT INTO Author_subject VALUES (7,6);
INSERT INTO Author_subject VALUES (8,6);
INSERT INTO Author_subject VALUES (9,6);
INSERT INTO Author_subject VALUES (9,10);



INSERT INTO Book_author VALUES (1,1);
INSERT INTO Book_author VALUES (2,3);
INSERT INTO Book_author VALUES (3,5);
INSERT INTO Book_author VALUES (4,2);
INSERT INTO Book_author VALUES (5,4);
INSERT INTO Book_author VALUES (6,10);
INSERT INTO Book_author VALUES (7,7);
INSERT INTO Book_author VALUES (8,9);
INSERT INTO Book_author VALUES (9,8);
INSERT INTO Book_author VALUES (10,6);
