<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>成功下单</title>
    <link rel="stylesheet" href="style/booking.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- 引入 layui.css -->
    <link href="//unpkg.com/layui@2.8.0/dist/css/layui.css" rel="stylesheet">
    <!-- 引入 layui.js -->
    <script src="//unpkg.com/layui@2.8.0/dist/layui.js"></script>
</head>
<body>

<div class="product-detail-container">
    <div class="product-images">
        <img src="img/order.jpg" alt="商品主图" class="main-image">
    </div>
    <div class="product-info">
        <%
            // 获取通过请求传递的订单编号列表
            List<Integer> orderIds = (List<Integer>) request.getAttribute("orderIds");
            Integer orderId1 = (Integer) request.getAttribute("orderId");

            // 处理 orderId1 为空的情况
            if (orderId1 == null) {
                orderId1 = 0;  // 设置为默认值 0
            }

            // 判断订单是否为空
            if (orderId1 == 0 && (orderIds == null || orderIds.isEmpty())) {
        %>
        <h1>订单创建失败！</h1>
        <%
        } else if (orderId1 != 0) {
        %>
        <h1>您的订单编号是：<%=orderId1%></h1>
        <%
        } else if (orderIds != null && !orderIds.isEmpty()) {
        %>
        <ul>
            <%
                // 遍历订单编号并显示
                for (Integer orderId : orderIds) {
            %>
            <li style="font-size: larger">订单编号: <%= orderId %></li>
            <%
                }
            %>
        </ul>
        <%
            }

            String userName = (String) request.getAttribute("userName");
            if (userName == null) {
        %>
        <h2>用户信息缺失！</h2>
        <%
            }
        %>
        <h2 style="margin-top: 50px">正在制作中...</h2>
        <div class="layui-btn-container" style="margin-top: 100px">
            <button type="button" class="layui-btn layui-btn-warm layui-btn-radius" onclick="redirectToShopping()">继续下单</button>
            <button type="button" class="layui-btn layui-btn-danger layui-btn-radius" onclick="redirectToOrder()">查看我的历史订单</button>
        </div>
    </div>
</div>
<!-- 页面底部可以添加其他内容，如页脚 -->
<script>
    function redirectToShopping() {
        // 获取 userName
        var userName = "<%= userName %>"; // 从 JSP 中获取 userName
        // 构建跳转 URL
        var url = "shopping.jsp?userName=" + encodeURIComponent(userName);
        // 跳转到 shopping.jsp
        window.location.href = url;
    }

    function redirectToOrder() {
        // 获取 userName
        var userName = "<%= userName %>"; // 从 JSP 中获取 userName
        // 构建跳转 URL
        var url = "userOrder.jsp?userName=" + encodeURIComponent(userName);
        // 跳转到 userOrder.jsp
        window.location.href = url;
    }
</script>

</body>
</html>
