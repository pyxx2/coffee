<%@ page import="com.coffee.vo.GoodsCar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.coffee.daoImpl.UserDaoImpl" %>
<%@ page import="com.coffee.dao.UserDao" %>
<%@ page import="com.coffee.vo.Goods" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>购物车页面</title>
    <link rel="stylesheet" href="style/car.css">
</head>
<body>

<%
    UserDao ud = new UserDaoImpl();
    String userName=(String)request.getAttribute("userName");
    if(userName==null){
        userName=request.getParameter("userName");
    }
    List<GoodsCar> gcs = (List<GoodsCar>)request.getAttribute("gcs");
    String ct = (String)request.getAttribute("cartable");
    System.out.println(ct);
    System.out.println("u:"+userName);
    if(ct==null){
        ct= ud.selectCartIdByName(userName);
        gcs=ud.selectCartOfAll(ct);
    }
    int i=0;
    int userid=ud.selectIdByUserName(userName);
%>

<header>
    <div class="header-logo">
        <a href="shopping.jsp?userName=<%=userName%>">返回商城</a>
    </div>
</header>
<%
    if(gcs.isEmpty()){
%>
<div class="cart-container">
    <h1>当前购物车中什么都没有，快去加入一些商品吧!</h1>
</div>
<%
}else{
%>
<div class="cart-container">
    <%  for(GoodsCar gc:gcs){
        i++;
        int goodsid = gc.getId();
        boolean flag=ud.selectFromStore(goodsid);
        if(!flag){
            boolean flag1=ud.delete(ct,goodsid);
        }else {
    %>
    <div class="list-container">
        <div class="check-and-image">
            <input type="checkbox" class="item-checkbox" data-price="<%=gc.getPrice()%>" data-num="<%=gc.getNum()%>" onchange="updateTotal()">
            <a href="BookingServlet?goodsid=<%=goodsid%>&userid=<%=userid%>" class="product-photo-link">
                <img src="img/<%=gc.getImage()%>" alt="商品图片" class="item-image">
            </a>
        </div>
        <div class="item-details">
            <div class="item-name-and-price">
                <h3 class="item-name"><%=gc.getName()%></h3>
                <p class="item-price">￥<%=gc.getPrice()%></p>
                <div class="quantity-buttons">
                    <button class="btn-decrease" data-id="<%= goodsid %>" data-cart="<%= ct %>">-</button>
                    <input type="number" class="quantity-input" value="<%= gc.getNum() %>" min="1" data-id="<%= goodsid %>" data-cart="<%= ct %>">
                    <button class="btn-increase" data-id="<%= goodsid %>" data-cart="<%= ct %>">+</button>
                </div>
                <div class="action-buttons">
                    <button class="btn-remove"><a href="DeleteServlet?goodscarid=<%=gc.getId()%>&cartable=<%=ct%>&userName=<%=userName%>" style="text-decoration: none;color: white; ">删除</a> </button>
                </div>
            </div>
        </div>
    </div>
    <%}}}%>
    <div class="fixed-window">
        <div class="total-info">
            <span class="label">合计：</span>
            <span class="price" id="totalPrice">￥0.00</span>
        </div>
        <!-- 将选中的商品信息提交到 orderServlet -->
        <form id="orderForm" method="post" action="orderServlet">
            <input type="hidden" name="userName" value="<%=userName%>">
            <input type="hidden" name="cartable" value="<%=ct%>"> <!-- 确保 cartable 总是传递 -->
            <!-- 选中的商品信息会通过 JavaScript 填充到这里 -->
            <div id="selectedItems"></div>
            <button type="button" class="settle-btn" onclick="submitOrder()">结算</button>
        </form>
    </div>

</div>
<script>
    function updateTotal() {
        let total = 0;
        const checkboxes = document.querySelectorAll('.item-checkbox');
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                const price = parseFloat(checkbox.getAttribute('data-price'));
                const number=parseInt(checkbox.getAttribute('data-num'))
                total += price*number; // 累加选中的商品价格
            }
        });
        document.getElementById('totalPrice').innerText = '￥' + total.toFixed(2); // 更新合计
    }
    function submitOrder() {
        const checkboxes = document.querySelectorAll('.item-checkbox');
        const selectedItemsDiv = document.getElementById('selectedItems');
        selectedItemsDiv.innerHTML = ''; // 清空之前的内容

        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                const goodsid = checkbox.closest('.list-container').querySelector('.product-photo-link').getAttribute('href').split('goodsid=')[1].split('&')[0];
                const quantity = checkbox.closest('.list-container').querySelector('.quantity-input').value;
                const price = checkbox.getAttribute('data-price');
                const goodscarid = checkbox.closest('.list-container').querySelector('.btn-remove a').getAttribute('href').split('goodscarid=')[1].split('&')[0]; // 获取 goodscarid

                // 创建隐藏的 input 元素传递商品信息
                const goodsidInput = document.createElement('input');
                goodsidInput.type = 'hidden';
                goodsidInput.name = 'goodsid[]'; // 使用数组格式的参数名
                goodsidInput.value = goodsid;

                const quantityInput = document.createElement('input');
                quantityInput.type = 'hidden';
                quantityInput.name = 'selfnum[]';
                quantityInput.value = quantity;

                const priceInput = document.createElement('input');
                priceInput.type = 'hidden';
                priceInput.name = 'totalPrice[]';
                priceInput.value = price * quantity;

                // 创建隐藏的 input 元素传递 goodscarid 和 cartable
                const goodscaridInput = document.createElement('input');
                goodscaridInput.type = 'hidden';
                goodscaridInput.name = 'goodscarid[]';
                goodscaridInput.value = goodscarid;


                // 将所有输入字段添加到表单中
                selectedItemsDiv.appendChild(goodsidInput);
                selectedItemsDiv.appendChild(quantityInput);
                selectedItemsDiv.appendChild(priceInput);
                selectedItemsDiv.appendChild(goodscaridInput); // 添加 goodscarid 到表单

            }
        });

        // 提交表单
        if (selectedItemsDiv.children.length > 0) {
            document.getElementById('orderForm').submit();
        } else {
            alert('请至少选择一个商品进行结算');
        }
    }
</script>
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

    // 更新数据库中的数量
    function updateNumInDB(num, goodsId) {
        const cartable = document.querySelector(`.btn-increase[data-id="${goodsId}"]`).getAttribute('data-cart');
        console.log("Sending request with num:", num, "goodsId:", goodsId, "cartable:", cartable); // 检查传递的参数
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'ChangeCartNumServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log("数据库更新成功");
            } else if (xhr.readyState === 4) {
                console.error("请求失败，状态码:", xhr.status); // 打印错误状态
            }
        };
        xhr.send(`num=${num}&goodsId=${goodsId}&ct=${cartable}`);
    }

</script>
<script src="style/cart.js"></script>
</body>
</html>
