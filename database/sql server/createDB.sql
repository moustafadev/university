EXEC sp_helpdb BookshopDB;

CREATE TABLE Authors
(
    AuthorsID INT IDENTITY NOT NULL,
    FirstName VARCHAR(30) NOT NULL DEFAULT 'unknown',
    LastName VARCHAR(30) NULL,
    YearBorn CHAR(4) NULL,
    YearDied CHAR(4)NULL DEFAULT 'NO'
    );

ALTER TABLE AUTHORS ADD Descr VARCHAR(200) NOT NULL;

CREATE TABLE Books
(
    BookID INT NOT NULL Primary key,
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NULL
);

CREATE TABLE BookAuthor
(
    BookID INT NOT NULL,
    AuthorID INT NOT NULL
);

ALTER TABLE BookAuthor ADD PRIMARY KEY (BookID, AuthorID);

-- связи между таблицами BookAuthor и Books
ALTER TABLE BookAuthor
ADD CONSTRAINT BookID_Link
FOREIGN KEY (BookID) REFERENCES Books (BookID);



ALTER TABLE Authors ADD PRIMARY KEY (AuthorID);



ALTER TABLE BookAuthor
ADD CONSTRAINT AuthorID_Link
FOREIGN KEY (AuthorID) REFERENCES Authors (AuthorID);


ALTER TABLE Authors ADD CHECK (YearBorn LIKE '[1-2][0,6-9][0-9][0-9]');

ALTER TABLE Authors ADD CHECK (YearDied LIKE '[1-2][0,6-9][0-9][0-9]' OR YearDied
LIKE 'no');

ALTER TABLE Authors ADD CHECK (YearDied > YearBorn);


INSERT INTO Authors VALUES ('Fedor', 'Dostoyevskiy', '1821', '1881', 'Russian
writer');
INSERT INTO Authors VALUES ('Mikhail', 'Lermontov', '1814', '1841', 'Russian
poetry');
INSERT INTO Authors VALUES ('Teodor', 'Draizer', '1871', '1945', 'American
writer');

INSERT INTO Books VALUES (1, 'Idiot', 'Novel');
INSERT INTO Books VALUES (2, 'Borodino', 'Poem');
INSERT INTO Books VALUES (3, 'The American tradegy', 'Novel');

SELECT *FROM Authors