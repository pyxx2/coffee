<%@ page import="com.coffee.vo.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 视口设置 -->
    <title>后台管理</title>
    <link rel="stylesheet" href="style/login.css"> <!-- 引入CSS样式表 -->
    <style>
        @media (max-width: 768px) {
            .login-container {
                padding: 10px;
                width: 90%;
                margin: 0 auto;
            }

            .form-container {
                display: flex;
                flex-direction: column;
            }

            .login-form input {
                padding: 12px;
                font-size: 1em;
            }

            .login-button {
                padding: 12px;
                font-size: 1em;
            }

            .forgot-password {
                font-size: 0.9em;
                margin-top: 10px;
            }
        }
    </style>
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
