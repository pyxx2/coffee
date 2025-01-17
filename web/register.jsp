<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 视口设置 -->
    <title>用户注册页面</title>
    <link rel="stylesheet" href="style/register.css">
    <script type="text/javascript">
        window.onload = function() {
            // 检查是否有错误信息，并弹出提示框
            var errorMessage = "<%= request.getAttribute("error") %>";
            if (errorMessage !== "null" && errorMessage !== "") {
                alert(errorMessage);
            }
        };
    </script>
    <style>
        @media (max-width: 768px) {
            .register-container {
                padding: 10px;
                width: 90%;
                margin: 0 auto;
            }

            .register-form {
                display: flex;
                flex-direction: column;
            }

            .input-group {
                margin-bottom: 15px;
            }

            .register-button {
                padding: 12px;
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="header-logo">
        <a href="login.jsp">去登录</a>
    </div>
</header>
<div class="register-container">
    <form action="RegisterServlet" method="post" class="register-form">
        <h1>用户注册</h1>
        <div class="input-group">
            <label>用户名:</label>
            <input type="text" name="username" required>
        </div>
        <div class="input-group">
            <label>电话号码:</label>
            <input type="text" name="tel" required>
        </div>
        <div class="input-group">
            <label>密码:</label>
            <input type="password" name="pwd1" required>
        </div>
        <div class="input-group">
            <label>确认密码:</label>
            <input type="password" name="pwd2" required>
        </div>
        <button type="submit" class="register-button">注册</button>
    </form>
</div>
</body>
</html>
