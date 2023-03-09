SELECT Authors.FirstName, Authors.LastName, Books.Genre FROM Authors LEFT JOIN Books 
ON Authors.AuthorsID = Books.BookID
ORDER BY Genre
FOR XML RAW


SELECT Authors.FirstName, Authors.LastName, Books.Genre FROM Authors LEFT JOIN Books 
ON Authors.AuthorsID = Books.BookID
ORDER BY Genre
FOR XML AUTO, ROOT



SELECT Authors.FirstName, Authors.LastName, Books.Genre FROM Authors LEFT JOIN Books 
ON Authors.AuthorsID = Books.BookID
ORDER BY Genre
FOR XML AUTO, ELEMENTS




SELECT 1 AS Tag,
NULL AS Parent,
UserID AS [User!1!UserID], UserName AS [User!1!Name!Element] FROM Users
FOR XML EXPLICIT, ROOT



SELECT UserID "@userID", UserName "UserName",
Email "Email"
FROM users
FOR XML PATH, ROOT



SELECT 1 AS Tag,
NULL AS Parent,
UserID AS [User!1!UserId], UserName AS [User!1!UserName!Element],Email
 AS [User!1!Email!Element] FROM users
FOR XML EXPLICIT, ROOT



