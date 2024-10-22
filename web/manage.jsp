<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理页面</title>
    <link href="//unpkg.com/layui@2.8.0/dist/css/layui.css" rel="stylesheet">
    <script src="//unpkg.com/layui@2.8.0/dist/layui.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            background-image: url('img/managerBeijin.jpg'); /* 设置背景图片 */
            background-size: cover; /* 背景图片覆盖整个页面 */
            background-position: center; /* 背景图片居中 */
        }

        .layui-nav {
            background-color: rgba(0, 22, 68, 0.8); /* 半透明背景 */
            border-radius: 5px;
            padding: 10px;
        }

        .layui-nav-item a {
            color: white;
            text-decoration: none;
            padding: 10px;
            display: block;
        }

        .layui-nav-item a:hover {
            background-color: rgba(0, 22, 68, 0.6); /* 半透明效果 */
            border-radius: 3px;
        }

        /* 响应式样式 */
        @media (max-width: 600px) {
            body {
                padding: 10px;
            }

            .layui-nav {
                padding: 5px;
            }

            .layui-nav-item a {
                padding: 8px;
            }
        }
    </style>
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
