<%@ page import="com.coffee.vo.User" %><%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: Dell--%>
<%--  Date: 2024-07-12--%>
<%--  Time: 11:47--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Title</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<form action="LoginServlet" method="get">--%>
<%--    <p>id:<input type="text" name="id"></p>--%>
<%--    <p>password:<input type="text" name="password"></p>--%>
<%--    <p><input type="submit" value="提交"></p>--%>
<%--</form>--%>
<%--</body>--%>
<%--</html>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
    <link rel="stylesheet" href="style/login.css"> <!-- 引入CSS样式表 -->
</head>
<body>
<header>

</header>
<div class="login-container">
    <div class="form-container">
        <form action="ManagerLoginServlet" method="post" class="login-form">
            <h1>管理员登录</h1>
            <input type="text" name="name" placeholder="name" required>
            <input type="password" name="password" placeholder="密码" required>
            <a href="login.jsp" class="forgot-password">用户登录</a>
            <button type="submit" class="login-button">登录</button>
        </form>
    </div>
</div>
</body>
</html>