<%@ page import="java.util.List" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Disneyland</title>
    <link rel="stylesheet" href="style/index2.css">
    <link rel="stylesheet" href="style/footer.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        header {
            background-color: rgba(0, 16, 89, 0.51);
            color: white;
            padding: 10px 20px;
            text-align: center;
        }

        header nav {
            margin-top: 10px;
        }

        nav a {
            color: white;
            margin: 0 10px;
            text-decoration: none;
        }

        .good {
            padding: 20px;
        }

        .go {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin: 10px;
            text-align: center;
        }

        .go img {
            width: 100%; /* 图片自适应宽度 */
            height: auto; /* 自适应高度 */
            max-width: 200px; /* 最大宽度限制 */
        }

        @media (max-width: 768px) {
            header {
                text-align: center;
            }

            .good {
                display: flex;
                flex-direction: column; /* 列布局 */
                align-items: center; /* 水平居中 */
            }

            .go {
                width: 80%; /* 移动设备上的商品框宽度 */
                margin: 10px auto; /* 自动左右外边距 */
            }

            .go img {
                max-width: 100%; /* 确保在移动设备上适应屏幕 */
            }

            main {
                display: flex;
                flex-direction: column; /* 列布局 */
                align-items: center; /* 水平居中 */
            }
        }

        @media (min-width: 769px) {
            main {
                display: flex;
                flex-wrap: wrap; /* 允许换行 */
                justify-content: center; /* 水平居中 */
            }

            .go {
                width: calc(25% - 40px); /* 四列布局 */
                margin: 10px; /* 商品框之间的间距 */
            }
        }

        footer {
            text-align: center;
            padding: 20px;
            background-color: #4CAF50;
            color: white;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>

<body>
<%
    String userName;
    userName = (String) request.getAttribute("userName");
    if (userName == null) {
        userName = request.getParameter("userName");
    }
    UserDao ud = new UserDaoImpl();
    User u = ud.selectUser(userName);
%>
<header>
    <h1>欢迎点餐</h1>
    <a href="index.jsp?userName=<%=userName%>">返回首页</a>
    <nav>
        <p><a class="login">尊贵的<%=u.getName()%>用户，你好！</a></p>
        <a class="quit" href="login.jsp">退出登录</a>
    </nav>
</header>

<%
    List<Goods> goods = ud.selectAll();
    int i=1;
%>
<main>


    <section class="good">
            <%for(Goods g:goods){
        if(i%4==1 && i!=1){
    %>
        <section class="good">
            <%}%>
            <div class="go">

                <a href="booking.jsp?goodsid=<%=g.getId()%>&userName=<%=u.getName()%>">

                    <div>
                        <img src="img/<%=g.getImage()%>" >
                        <h3><%=g.getName()%></h3>
                    </div>
                </a>
                <p align="left" >￥<%=g.getPrice()%></p>
            </div>
            <%if(i%4==0){
            %>
        </section>
            <%}%>
            <%i++;};%>
</main>
<footer>
    <p align="center">Copyright @ 2024 Disneyland All Rights Reserved. </p>
</footer>
</body>
</html>
