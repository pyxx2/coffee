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
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'ChangeNumServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    console.log("数据库更新成功");
                } else {
                    console.error("更新失败:", xhr.statusText);
                }
            }
        };
        xhr.send(`num=${num}&goodsId=${goodsId}`);
    }

    // 计算总价的相关逻辑，如果需要可以添加这里
    // ...
});
