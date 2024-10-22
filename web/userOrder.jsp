<%@ page import="com.coffee.vo.GoodsCar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.dao.OrderDao" %>
<%@ page import="com.coffee.daoImpl.OrderDaoImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coffee.vo.Order" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单</title>
    <link rel="stylesheet" href="style/car.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        .cart-container {
            margin-top: 20px;
        }

        .list-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
            border-radius: 5px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px; /* 每个订单之间的间距 */
        }

        .item-details {
            display: flex;
            flex-direction: column; /* 垂直排列 */
            flex-grow: 1; /* 占据剩余空间 */
        }

        .item-name-and-price {
            display: flex;
            flex-direction: column; /* 垂直排列 */
            flex-grow: 1; /* 占据剩余空间 */
        }

        .item-price {
            font-size: 1.2em; /* 调整价格字体大小 */
            color: #4CAF50; /* 绿色 */
        }

        /* 响应式样式 */
        @media (max-width: 768px) {
            .list-container {
                flex-direction: column; /* 列表容器在小屏幕上垂直排列 */
                align-items: flex-start; /* 左对齐 */
            }

            .item-details {
                align-items: flex-start; /* 左对齐 */
            }

            .item-price {
                font-size: 1em; /* 调整价格字体大小 */
            }
        }
    </style>
</head>
<body>

<%
    String userName = request.getParameter("userName");
    OrderDao od = new OrderDaoImpl();
    ArrayList<Order> orders = od.selectOrder(userName);
%>
<header>
    <div class="header-logo">
        <a href="shopping.jsp?userName=<%= userName %>" style="color: #FFFfff">返回商城</a>
    </div>
</header>
<%
    if (orders.isEmpty()) {
%>
<div class="cart-container">
    <h1>当前没有历史订单，快去下单吧!</h1>
</div>
<%
} else {
%>
<div class="cart-container">
    <% for (Order order : orders) {
        int orderId = order.getOrderId();
        int goodsId = order.getGoodsId();
        UserDao ud = new UserDaoImpl();
        Goods good = ud.selectGoods(goodsId);
        String goodName = good.getName();
    %>
    <div class="list-container">
        <div class="item-details">
            <div class="item-name-and-price">
                <h3 style="margin-right: 30px">订单编号：<%= orderId %></h3>
                <h3 style="margin-right: 40px"><%= goodName %></h3>
                <h3 style="margin-right: 40px">数量：<%= order.getNum() %></h3>
                <h3 style="margin-right: 40px">状态：<%= order.getStatus() %></h3>
                <p class="item-price">￥<%= order.getPrice() %></p>
                <h5>时间：<%= order.getOrderTime() %></h5>
            </div>
        </div>
    </div>
    <% } %>
</div>
<% } %>
<script src="style/car.js"></script>
<script src="style/carAdd.js"></script>

</body>
</html>
