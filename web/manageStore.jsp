<%@ page import="com.coffee.dao.ManagerDao" %>
<%@ page import="com.coffee.daoImpl.ManagerDaoImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>库存管理</title>
    <link rel="stylesheet" href="style/car.css">
    <style>
        .add{
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 10px;
        }
    </style>
</head>
<body>

<%
    String deleteMessage = (String) request.getAttribute("deleteMessage");
    if (deleteMessage != null) {
%>
<script>
    alert("<%= deleteMessage %>");
</script>
<%
    }
%>


<%
    ManagerDao md = new ManagerDaoImpl();
    ArrayList<Goods> list = md.selectAllGoods();
%>

<header>
    <div class="header-logo">
        <a href="manage.jsp" style="color: #FFFfff">返回</a>
    </div>
</header>

<div class="cart-container">
    <button class="add"><a href="addGood.jsp">添加商品</a></button>
    <% if (list.isEmpty()) { %>
    <h1>库存无商品，快去添加吧</h1>
    <% } else { %>
    <% for (Goods li : list) {
        int goodsid = li.getId();
        String name = li.getName();
        Float price = li.getPrice();
        int num = li.getNum();
        String img = li.getImage();
        String msg = li.getMessage();
    %>
    <div class="list-container">
        <div class="check-and-image">
            <input type="checkbox" class="item-checkbox">
            <a class="product-photo-link">
                <img src="img/<%= img %>" alt="商品图片" class="item-image">
            </a>
        </div>
        <div class="item-details">
            <div class="item-name-and-price">
                <h3 class="item-name"><%= name %></h3>
                <div class="quantity-buttons" style="margin-right: 30px">
                    <button class="btn-decrease" data-id="<%= goodsid %>">-</button>
                    <input type="number" class="quantity-input" value="<%= num %>" min="1" data-id="<%= goodsid %>">
                    <button class="btn-increase" data-id="<%= goodsid %>">+</button>
                </div>
                <p style="margin-right: 30px"><%= msg %></p>
                <p style="font-size: larger">￥<%= price %></p>
                <div class="action-buttons">
                    <button class="btn-remove">
                        <a href="DeleteAllServlet?goodsId=<%= goodsid %>" style="text-decoration: none;color: white;">删除</a>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <% } %>
    <% } %>
</div>
<script src="style/store.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const increaseButtons = document.querySelectorAll('.btn-increase');
        const decreaseButtons = document.querySelectorAll('.btn-decrease');

        increaseButtons.forEach(button => {
            button.addEventListener('click', function() {
                let input = this.nextElementSibling;
                let newNum = parseInt(input.value) + 1;
                input.value = newNum;
                updateNumInDB(newNum, this.getAttribute('data-id'));
            });
        });

        decreaseButtons.forEach(button => {
            button.addEventListener('click', function() {
                let input = this.previousElementSibling;
                let newNum = Math.max(1, parseInt(input.value) - 1);
                input.value = newNum;
                updateNumInDB(newNum, this.getAttribute('data-id'));
            });
        });
    });

    function updateNumInDB(num, goodsId) {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'ChangeNumServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("数据库更新成功");
            }
        };
        xhr.send(`num=${num}&goodsId=${goodsId}`);
    }
</script>

</body>
</html>
