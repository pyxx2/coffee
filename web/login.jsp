<%@ page import="com.coffee.vo.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录</title>
    <link rel="stylesheet" href="style/login.css">
    <style>
        @media (max-width: 768px) {
            .login-container {
                padding: 10px;
            }

            .form-container {
                width: 90%;
                margin: 0 auto;
            }

            .login-form input, .login-form .login-button, .signup-button {
                font-size: 1em;
                padding: 12px;
            }

            .overlay-panel h1 {
                font-size: 1.2em;
            }

            .signup-button {
                padding: 12px 24px;
            }
        }
    </style>
</head>
<body>
<%
    String name = null;
    try {
        User u = (User) request.getAttribute("userinfo");
        name = u.getName();
    } catch (Exception e) {
    }
%>
<header>
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
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var signupButton = document.getElementById('signupButton');
        signupButton.addEventListener('click', function () {
            window.location.href = 'register.jsp';
        });
    });
</script>

</body>
</html>
