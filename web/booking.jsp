<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品详情</title>
    <link rel="stylesheet" href="style/booking.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- 引入 layui.css -->
    <link href="//unpkg.com/layui@2.8.0/dist/css/layui.css" rel="stylesheet">
    <!-- 引入 layui.js -->
    <script src="//unpkg.com/layui@2.8.0/dist/layui.js"></script>
    <%
        String goodsidStr = request.getParameter("goodsid");
        int goodsid = 0;
        if (goodsidStr != null) {
            try {
                goodsid = Integer.parseInt(goodsidStr);  // 将 String 转换为 int
            } catch (NumberFormatException e) {
                out.println("Invalid Goods ID format!");
            }
        } else {
            out.println("Goods ID is missing!");
        }

        String userName = (String) request.getAttribute("userName");
        if (userName == null) {
            userName = request.getParameter("userName");  // 如果通过 Attribute 获取不到，则从 URL 参数中获取
        }

        UserDao ud = new UserDaoImpl();
        Goods g = ud.selectGoods(goodsid);
    %>
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
            if (a > 1) {
                a--;
            }
            textbox.value = a;
        }

        function calculateTotalPrice() {
            var price = parseFloat(<%=g.getPrice()%>); // 商品价格
            var quantity = parseInt(document.getElementById("text").value, 10); // 获取当前数量
            var totalPrice = price * quantity;
            document.getElementById("totalprice").value = totalPrice.toFixed(2); // 设置总价并保留2位小数
        }

        function placeOrder() {
            calculateTotalPrice();
            document.getElementById("orderForm").submit(); // 提交表单
        }
    </script>
</head>
<body>

<header>
    <div class="header-logo">
        <!-- 返回商城首页链接可以在这里添加 -->
    </div>
</header>

<div class="product-detail-container">
    <div class="product-images">
        <img src="img/<%=g.getImage()%>.jpg" alt="商品主图" class="main-image">
    </div>
    <div class="product-info">
        <h1 class="product-name"><%=g.getName()%></h1>
        <p class="product-price">￥<%=g.getPrice()%></p>
        <div class="product-description">
            <%=g.getMessage()%>
        </div>

        <!-- 商品数量和加入购物车表单 -->
        <div class="product-actions">
            <button class="sub" id="sub" onclick="sub1()">-</button>
            <form method="get" action="SuccessServlet" class="updown">
                <input type="hidden" name="goodsid" value="<%=goodsid%>" >
                <input type="hidden" name="userName" value="<%=userName%>" >
                <input type="text" id="text" name="selfnum" value="1" >
                <input type="submit" class="car" value="加入购物车">
            </form>
            <button class="add" id="add" onclick="add1()">+</button>

            <!-- 立即点单表单 -->
            <form id="orderForm" method="get" action="orderServlet">
                <input type="hidden" name="goodsid" value="<%=goodsid%>">
                <input type="hidden" name="userName" value="<%=userName%>">
                <input type="hidden" id="totalprice" name="totalPrice" value="">
                <input type="hidden" name="selfnum" value="1" id="selfnumField">
                <button type="button" class="buy" onclick="placeOrder()">
                    <i class="fas fa-shopping-cart"></i> 立即点单
                </button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
