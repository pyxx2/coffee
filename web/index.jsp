<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>瑞幸coffee</title>
    <link rel="stylesheet" href="style/homepage.css">
    <link rel="stylesheet" href="style/navigation.css">
    <link rel="stylesheet" href="style/footer.css">
    <script type="text/javascript" src="style/canvasStar.js"></script>

    <style>
        img.disney-logo {
            max-width: 100%;
            height: auto;
            margin-top: 15px;
            align-content: center;
        }

    </style>
</head>

<body bgcolor="#ffffff">
<canvas id="canvas"></canvas>
<%
    String userName=(String) request.getAttribute("userName");
    if(userName==null){
        userName=request.getParameter("userName");
    }
%>
<header>
    <img class="disney-logo" src="img/logo2.png">
    <div>
        <ul class="navigation">
            <li><a href="homepage.jsp">首页</a></li>
            <li><a href="#">我的</a>
                <ul>
                    <li><a href="goodsCar.jsp?userName=<%=userName%>">购物车</a></li>
                    <li><a href="userOrder.jsp?userName=<%=userName%>">历史订单</a></li>
                </ul>
            </li>
        </ul>
    </div>
</header>
<!-- 创建外部展示容器 -->
<div class="banner-container">
    <!-- 创建图片存储容器 -->
    <div class="banner-img-container">
        <img src="img/rolling1.jpg" alt="">
        <img src="img/rolling2.jpeg" alt="">
        <img src="img/rolling3.jpg" alt="">
    </div>
</div>
<div class="member">
    <div class="title">
        <h2 class="member-title">点餐商城</h2>
        <a href="shopping.jsp?userName=<%=userName%>">More&gt;&gt;</a>
    </div>
    <div class="member-part">
        <div class="cpBox">
            <a ><img src="img/s1.jpg"></a>
        </div>
        <div class="cpBox">
            <a ><img src="img/s2.jpg"></a>
        </div>
        <div class="cpBox">
            <a ><img src="img/s3.jpg"></a>
        </div>
        <div class="cpBox">
            <a ><img src="img/s4.jpg"></a>
        </div>
        <div class="cpBox">
            <a ><img src="img/s5.jpg"></a>
        </div>
    </div>
</div>
<div class="movies">
    <div class="movie-left">
        <img src="img/xinpin.jpg">
    </div>
    <div class="movie-right">
        <h3>小黄油拿铁</h3><br>
        <p>进口新西兰黄油 | 香醇不腻 | 内测第一</p><br>

    </div>
</div>
<div class="mall">
    <div class="mall-left">
        <div class="mall-content1">刘亦菲同款 | 热量约为2个苹果</div><br>
        <div class="mall-content2" style="margin-top: 40px">轻轻茉莉轻乳茶</div><br>

    </div>
    <div class="mall-right">
        <img src="img/liuyifei.jpg">
    </div>
</div>
<div class="park">
    <div class="title">
        <div class="title-star-inner">
            <img class="title-star1" src="image/star2.png">
        </div>
        <div class="park-title">关于我们</div>
        <div class="title-star-inner">
            <img class="title-star2" src="image/star2.png">
            <img class="title-star3" src="image/star3.png">
        </div>
    </div>
    <div class="shanghai">
        <a href="Shanghai.jsp">
            <img class="park-picture" src="img/about.jpg"><br>
            <h3>品牌使命</h3><br>
            <p>瑞幸咖啡以“创造幸运时刻，激发美好生活热望”为使命，为顾客创造幸运时刻。</p><br>

        </a>
    </div>
    <div class="hongkong">
        <a href="Hongkong.jsp">
            <img class="park-picture" src="img/about2.png"><br>
            <h3>品牌愿景</h3><br>
            <p>瑞幸咖啡始终致力于以新质生产力赋能行业品质升级，引领行业发展新趋势</p><br>

        </a>
    </div>
</div>
<div class="footer">
    <img class="footer1" src="img/logo2.png">
    <img src="img/code2.jpg" style="width: 100px; height: 100px;">
    <img class="footer3" src="img/code.jpg">
    <table class="footer4">
        <tr>
            <td>制作人：潘雅熙 </td>
        </tr>
        <tr>
            <td>时间：2024.10.11-2024.11.11</td>
        </tr>
    </table>
</div>
<div class="footer-bar">Copyright © 2024 西南财经大学pyxx 版权所有</div>
</body>
</html>
