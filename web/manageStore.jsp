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
        body {
            font-family: Arial, sans-serif;
            background-color: rgb(245, 245, 245);
            margin: 0;
            padding: 20px;
        }

        .add {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin-bottom: 20px; /* 为按钮添加底部间距 */
        }

        .cart-container {
            display: flex;
            flex-direction: column;
            gap: 20px; /* 为每个商品之间添加间距 */
        }

        .list-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.68);
            border-radius: 5px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .check-and-image {
            display: flex;
            align-items: center;
        }

        .item-image {
            width: 80px; /* 设置图片宽度 */
            height: auto; /* 自适应高度 */
        }

        .item-details {
            flex-grow: 1; /* 占据剩余空间 */
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .item-name-and-price {
            display: flex;
            flex-direction: column;
            flex-grow: 1; /* 占据剩余空间 */
        }

        .action-buttons {
            display: flex;
            align-items: center;
        }

        .btn-remove {
            background-color: #f44336; /* 红色背景 */
            border: none;
            color: white;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 3px;
        }

        /* 响应式样式 */
        @media (max-width: 768px) {
            .list-container {
                flex-direction: column;
                align-items: flex-start; /* 左对齐 */
            }

            .item-details {
                flex-direction: column;
                align-items: flex-start; /* 左对齐 */
            }

            .item-image {
                width: 100%; /* 图片自适应宽度 */
                height: auto; /* 自适应高度 */
            }

            .add {
                width: 100%; /* 按钮占满宽度 */
                font-size: 12px; /* 调整按钮字体大小 */
            }
        }

        @media (max-width: 480px) {
            .add {
                font-size: 10px; /* 更小的按钮字体大小 */
            }
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
    <button class="add"><a href="addGood.jsp" style="color: white; text-decoration: none;">添加商品</a></button>
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
            </div>
            <div class="action-buttons">
                <button class="btn-remove">
                    <a href="DeleteAllServlet?goodsId=<%= goodsid %>" style="text-decoration: none;color: white;">删除</a>
                </button>
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
