<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.dao.OrderDao" %>
<%@ page import="com.coffee.daoImpl.OrderDaoImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.coffee.vo.Order" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page import="com.coffee.dao.ManagerDao" %>
<%@ page import="com.coffee.daoImpl.ManagerDaoImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理</title>
    <link rel="stylesheet" href="style/car.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        header {
            background-color: #009688;
            padding: 10px;
            color: white;
            text-align: right;
        }

        .header-logo a {
            color: #ffffff;
            text-decoration: none;
            font-size: 18px;
        }

        .cart-container {
            margin-top: 20px;
        }

        .list-container {
            background-color: white;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .item-name-and-price {
            display: flex;
            flex-direction: column;
            flex-grow: 1; /* 让此部分占据剩余空间 */
        }

        .complete-order-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            padding: 8px 12px;
            cursor: pointer;
            margin-left: auto; /* 将按钮推到右侧 */
        }

        .complete-order-btn:hover {
            background-color: #45a049;
        }

        /* 响应式样式 */
        @media (max-width: 600px) {
            .item-details {
                flex-direction: column;
                align-items: flex-start;
            }

            .item-name-and-price {
                align-items: flex-start;
            }

            .header-logo a {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<%
    ManagerDao md = new ManagerDaoImpl();
    ArrayList<Order> orderlist = md.selectAllOrder();
    int i = 0;
%>
<header>
    <div class="header-logo">
        <a href="manage.jsp">返回</a>
    </div>
</header>
<%
    if(orderlist.isEmpty()) {
%>
<div class="cart-container">
    <h1>无订单记录</h1>
</div>
<%
} else {
%>
<div class="cart-container">
    <% for(Order order : orderlist) {
        i++;
        int orderId = order.getOrderId();
        int goodsId = order.getGoodsId();
        String userName = order.getUserName();
        UserDao ud = new UserDaoImpl();
        Goods good = ud.selectGoods(goodsId);
        String goodName = good.getName();
    %>
    <div class="list-container">
        <div class="item-details">
            <div class="item-name-and-price">
                <h3>订单编号：<%=orderId%></h3>
                <h3 style="color: #df5000;">用户：<%=userName%></h3>
                <h3><%=goodName%></h3>
                <h3>数量：<%=order.getNum()%></h3>
                <h3 style="color: #190e5f;">状态：<%=order.getStatus()%></h3>
                <p class="item-price" style="color: red;margin-left: 50px">￥<%=order.getPrice()%></p>
                <h5>时间：<%=order.getOrderTime()%></h5>
            </div>
            <button class="complete-order-btn" data-order-id="<%=orderId%>">完成订单</button>
        </div>
    </div>
    <% }} %>
</div>
<script>
    document.querySelectorAll('.complete-order-btn').forEach(button => {
        button.addEventListener('click', function() {
            const orderId = this.getAttribute('data-order-id');

            if (!orderId) {
                console.error("orderId is empty or undefined");
                return;
            }

            const requestUrl = `UpdateOrderServlet?orderId=` + orderId;

            fetch(requestUrl, { method: 'GET' })
                .then(response => {
                    if (response.ok) {
                        alert('订单状态已更新为已完成');
                        this.parentElement.querySelector('h3:nth-of-type(5)').textContent = '状态：已完成';
                    } else {
                        alert('更新失败');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('请求出错');
                });
        });
    });
</script>
</body>
</html>
