<%--
  Created by IntelliJ IDEA.
  User: 86178
  Date: 2024/10/16
  Time: 21:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理页面</title>
    <link href="//unpkg.com/layui@2.8.0/dist/css/layui.css" rel="stylesheet">
    <!-- 引入 layui.js -->
    <script src="//unpkg.com/layui@2.8.0/dist/layui.js"></script>
</head>
<body>
<div class="layui-nav" lay-filter="demo-filter-nav">
    <li class="layui-nav-item"><a href="manageStore.jsp">库存管理</a></li>
    <li class="layui-nav-item"><a href="manageOrder.jsp">订单管理</a></li>
</div>

<script>
    layui.use(function(){
        var element = layui.element;
        var layer = layui.layer;

        // 导航点击事件
        element.on('nav(demo-filter-nav)', function(elem){
            console.log(elem); // 得到当前点击的元素 jQuery 对象
            layer.msg(elem.text());
        });
    });
</script>

</body>
</html>
