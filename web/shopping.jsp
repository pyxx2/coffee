<%@ page import="java.util.List" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page import="com.coffee.db.DBConnection" %>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Disneyland</title>
    <link rel="stylesheet" href="style/index2.css">
    <link rel="stylesheet" href="style/footer.css">
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
    <section class="news">


    </section>

    <section class="good">
        <h4>周边好物疯狂购！！！</h4>
    </section>

    <section class="good">
            <%for(Goods g:goods){
        if(i%4==1 && i!=1){
    %>
        <section class="good">
            <%}%>
            <div class="go">

                <a href="booking.jsp?goodsid=<%=g.getId()%>&userName=<%=u.getName()%>">

                <div>
                        <img src="img/<%=g.getImage()%>.jpg" >
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
