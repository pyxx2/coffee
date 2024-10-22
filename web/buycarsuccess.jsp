<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/7/17
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品已成功加入购物车</title>
    <link rel="stylesheet" href="style/buycarsuccess.css">
</head>
<body>
<%
    int goodsid = (int)request.getAttribute("goodsid");
    String userName = (String) request.getAttribute("userName");
    UserDao ud = new UserDaoImpl();
    Goods g = ud.selectGoods(goodsid);
    int id=ud.selectIdByUserName(userName);
    System.out.println(userName);
    System.out.println("id:"+id);
%>
<header>


    <div class="header-logo">
        <a href="shopping.jsp?userName=<%=userName%>">返回商城首页</a>
    </div>
</header>
<section class="a">
    <div class="content-wrapper">
        <div class="b">
            <div class="car-header">
                <h1>商品已成功加入购物车!</h1>
            </div>
            <div class="d">
            <div style="width: 37%;position: relative;left: 20px;top: 12px;">
                <a href="BookingServlet?userName=<%=userName%>&goodsid=<%=goodsid%>" class="product-photo-link">
                    <img src="img/<%=g.getImage()%>" alt="商品图片" class="item-image">
                </a>
            </div>
            <div style="width: 63%;position: relative;top: 30px;left: -20px">
                <h3 class="item-name"><%=g.getName()%></h3>
                <p class="item-price">￥<%=g.getPrice()%></p>
                <div class="action-buttons">
                    <button class="btn-car" id="buyButton"><a href="GoodsCarServlet?cartable=<%="car"+id%>&userName=<%=userName%>" style="color: white; text-decoration: none">去购物车结算</a> </button>
                </div>
            </div>
            </div>
        </div>
        <div class="c">
            <%
                List<Goods> goods = ud.selectAll();
                int i =1;
                for(Goods gs:goods){
            %>
            <div class="goods">
                <div class="pic">
                    <a href="BookingServlet?userName=<%=userName%>&goodsid=<%=gs.getId()%>" class="product-photo-link">
                        <img src="img/<%=gs.getImage()%>" alt="商品图片" class="product-photo">
                    </a>
                </div>
                <div class="info">
                    <h3 class="item-name1"><%=gs.getName()%></h3>
                    <p class="item-price1">￥<%=gs.getPrice()%>></p>
                </div>
            </div><%}%>
        </div>
    </div>

</section>
</body>
</html>