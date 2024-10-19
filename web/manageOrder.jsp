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
</head>
<body>

<%
    ManagerDao md=new ManagerDaoImpl();
    ArrayList<Order> orderlist=md.selectAllOrder();
    int i = 0;
%>
<header>
    <div class="header-logo">
        <a href="manage.jsp" style="color: #FFFfff">返回</a>
    </div>
</header>
<%
    if(orderlist.isEmpty()){
%>
<div class="cart-container">
    <h1>无订单记录</h1>
</div>
<%
}else{
%>
<div class="cart-container">
    <%  for(Order order:orderlist){
        i++;
        int orderId = order.getOrderId();
        int goodsId = order.getGoodsId();
        String userName = order.getUserName();
        UserDao ud=new UserDaoImpl();
        Goods good=ud.selectGoods(goodsId);
        //获取商品名称
        String goodName=good.getName();
    %>
    <div class="list-container">
        <div class="item-details">
            <div class="item-name-and-price">
                <h3 style="margin-right: 30px">订单编号：<%=orderId%>   </h3>
                <h3 style="margin-right: 30px;color: #df5000">用户：<%=userName%>   </h3>
                <h3 style="margin-right: 30px;color: #000000"><%=goodName%></h3>
                <h3 style="margin-right: 30px">数量：<%=order.getNum()%></h3>
                <h3 style="margin-right: 50px;color: #190e5f">状态：<%=order.getStatus()%></h3>
                <p class="item-price" style="color: red">￥<%=order.getPrice()%></p>
                <h5>时间：<%=order.getOrderTime()%></h5>

                <!-- 添加完成订单按钮 -->
                <button class="complete-order-btn" data-order-id="<%=orderId%>">完成订单</button>

            </div>
        </div>
    </div>

    <%}}%>
</div>
<script>
    // 监听所有完成订单按钮的点击事件
    document.querySelectorAll('.complete-order-btn').forEach(button => {
        button.addEventListener('click', function() {
            // 获取当前按钮的订单ID
            const orderId = this.getAttribute('data-order-id');

            // 打印orderId，确保值正确
            console.log("Sending orderId:", orderId);

            // 验证 orderId 是否为空或 undefined
            if (!orderId) {
                console.error("orderId is empty or undefined");
                return;  // 如果为空，停止执行
            }

            // 发送请求到 UpdateOrderServlet
            const requestUrl = `UpdateOrderServlet?orderId=`+orderId;
            console.log("Request URL:", requestUrl);  // 打印最终的请求URL

            fetch(requestUrl, {
                method: 'GET'
            })
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
