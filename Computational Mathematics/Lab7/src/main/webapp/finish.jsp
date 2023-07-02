<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="data" class="com.flock.lab8.CalculationBean" scope="session"/>

<!DOCTYPE html>
<html lang="ru" xml:lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Финишная страница</title>
    <style>
        <%@include file="/WEB-INF/css/finish.css" %>
    </style>
</head>
<body>
<h1>Финишная страница</h1>
<table>
    <caption></caption>
    <thead>
    <tr>
        <th>Результат выполнения функции</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
            <%= data.getResult() %>
        </td>
    </tr>
    </tbody>
</table>

<a href="main.jsp">
    Home
    <%
        data.increaseCounter();
    %>
</a>
</body>
</html>