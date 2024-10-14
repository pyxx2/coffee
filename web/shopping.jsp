<%@ page import="java.util.List" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page import="com.coffee.db.DBConnection" %>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.User" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2024-07-09
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Disneyland</title>
    <link rel="stylesheet" href="index2.css">
    <link rel="stylesheet" href="footer.css">
</head>

<body>
<%
//    int userid=0;
//    String username;
//    try{userid = (int) request.getAttribute("userid");}
//    catch (Exception e){userid = Integer.parseInt(request.getParameter("userid"));}
//    UserDao ud = new UserDaoImpl();
//    User u = ud.selectUser(userid);
//    username = u.getName();
%>
<header>
    <h1>欢迎点餐</h1>
    <nav>
<%--        <p><a class="login">尊贵的<%=username%>用户，你好！</a></p>--%>
        <p><a class="login">尊贵的xxx用户，你好！</a></p>
        <a class="quit" href="login.jsp">退出登录</a>
    </nav>
</header>

<%
//    List<Goods> goods = ud.selectAll();
    List<Goods> goods = new ArrayList<>();

    Goods goods1 = new Goods(
            1001,
            "生椰拿铁",
            139.00F,
            40,
            "1",
            "迪士尼官方史迪奇海滩日落系列限定毛绒玩偶抱枕公仔钥匙挂件，是一款集可爱与实用于一体的精致礼物。"
    );

    // 商品 2
    Goods goods2 = new Goods(
            1002,
            "轻轻茉莉",
            139.00F,
            14,
            "2",
            "迪士尼官方草莓熊正版毛绒玩具玩偶大号公仔挂件，专为女生设计的生日礼物，融合了可爱与实用性。"
    );

    // 商品 3
    Goods goods3 = new Goods(
            1003,
            "拿铁",
            159.00F,
            49,
            "11",
            "这款玩具总动员巴斯光年胡迪玩偶公仔手办，完美还原了动画中的经典角色形象。"
    );



    // 添加到列表中
    goods.add(goods1);
    goods.add(goods2);
    goods.add(goods3);
    int i =1;
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
                <%
                    int goodsid = g.getId();
                %>
                <a href="BookingServlet?goodsid=<%=goodsid%>">
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
        <div class="fixed-window">
<%--            <a href="GoodsCarServlet?cartable=<%=u.getCartable()%>">查看我的购物车</a>--%>
        </div>


</main>

<footer>
    <p align="center">Copyright @ 2024 Disneyland All Rights Reserved. </p>
</footer>
</body>
</html>
