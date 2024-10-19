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
    <title>用户登录</title>
    <link rel="stylesheet" href="style/login.css"> <!-- 引入CSS样式表 -->
</head>
<body>
<%
//    int id = 0;
    String name=null;
    try {
        User u = (User) request.getAttribute("userinfo");
//        id = u.getId();
        name = u.getName();

    }catch(Exception e) {
    }
%>
<header>
    <div class="header-logo">
        <a href="index1.jsp">商城首页</a>
    </div>
</header>
<div class="login-container">
    <div class="form-container">
        <form action="LoginServlet" method="post" class="login-form">
            <h1>登录</h1>
            <input type="text" name="name" placeholder="用户名" required>

            <input type="password" name="password" placeholder="密码" required>

            <a href="manageLogin.jsp" class="forgot-password">管理员登录</a>
            <button type="submit" class="login-button">登录</button>
        </form>
        <div class="overlay-panel">
            <h1>没有帐号？</h1>
            <p>立即注册加入我们</p>
            <p>和我们一起开始旅程吧</p>
            <button id="signupButton" class="signup-button">注册</button>
            <script>
                // 等待DOM加载完成
                document.addEventListener('DOMContentLoaded', function() {
                    // 获取注册按钮元素
                    var signupButton = document.getElementById('signupButton');

                    // 为注册按钮添加点击事件监听器
                    signupButton.addEventListener('click', function() {
                        // 使用window.location.href实现页面跳转
                        window.location.href = 'register.jsp';
                    });
                });
            </script>
        </div>
    </div>
</div>
</body>
</html>