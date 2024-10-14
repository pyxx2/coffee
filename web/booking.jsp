<%--<%@ page import="com.coffee.vo.GoodsCar" %>--%>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品详情</title>
    <link rel="stylesheet" href="booking.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function add1(){
            var textbox = document.getElementById("text");
            var a = parseInt(textbox.value,10);
            a++;
            textbox.value = a;
        }
        function sub1(){
            var textbox = document.getElementById("text");
            var a = parseInt(textbox.value,10);
            a--;
            textbox.value = a;
        }
    </script>
</head>
<body>
<%
//    int goodsid = (int)request.getAttribute("goodsid");
//    int userid = (int)request.getAttribute("userid");
//    UserDao ud = new UserDaoImpl();
//    Goods g = ud.selectGoods(goodsid);
%>
<header>
    <div class="header-logo">
<%--        <a href="index2.jsp?userid=<%=userid%>">返回商城首页</a>--%>
    </div>
</header>
<div class="product-detail-container">
    <div class="product-images">
<%--        <img src="img/<%=g.getImage()%>.jpg" alt="商品主图" class="main-image">--%>
    <img src="img/1.jpg" alt="商品主图" class="main-image">
        <!-- 缩略图列表可以在这里添加 -->
    </div>
    <div class="product-info">
<%--        <h1 class="product-name"><%=g.getName()%></h1>--%>
    <h1 class="product-name">生椰拿铁</h1>
<%--        <p class="product-price">￥<%=g.getPrice()%></p>--%>
    <p class="product-price">￥19</p>
<%--        <div class="product-description">--%>
<%--            <%=g.getMessage()%>--%>
<%--        </div>--%>
        <div class="product-description">
            非常好喝
        </div>
        <div class="product-actions">
            <button class="sub" id="sub" onclick="sub1()">-</button>
            <form method="get" action="SuccessServlet" class="updown">
<%--                <input type="hidden" name="goodsid" value="<%=goodsid%>" >--%>
    <input type="hidden" name="goodsid" value="1" >
<%--                <input type="hidden" name="userid" value="<%=userid%>" >--%>
                <input type="text" id="text" name="selfnum" value="1" >
                <input type="submit" class="car" value="加入购物车">
            </form>
            <button class="add" id="add" onclick="add1()">+</button>
            <button class="buy">
                <i class="fas fa-shopping-cart"></i> 立即点单
            </button>
            <button class="fav">
                <i class="fa fa-heart"></i> 收藏
            </button>
        </div>
    </div>
</div>
<!-- 页面底部可以添加其他内容，如页脚 -->
</body>
</html>