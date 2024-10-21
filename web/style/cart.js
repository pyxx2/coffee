document.addEventListener('DOMContentLoaded', function() {
    const quantityInputs = document.querySelectorAll('.quantity-input');

    // 增加数量和减少数量的事件处理
    function updateQuantity(button, increment) {
        let input = button.closest('.quantity-buttons').querySelector('.quantity-input');
        let newNum = Math.max(1, parseInt(input.value) + increment);
        input.value = newNum;

        // 调用服务器更新数据库中的数量
        updateNumInDB(newNum, button.getAttribute('data-id'));
    }

    document.querySelectorAll('.btn-increase').forEach(button => {
        button.addEventListener('click', function() {
            updateQuantity(this, 1); // 增加1
        });
    });

    document.querySelectorAll('.btn-decrease').forEach(button => {
        button.addEventListener('click', function() {
            updateQuantity(this, -1); // 减少1
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

});
