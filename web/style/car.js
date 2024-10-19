document.addEventListener('DOMContentLoaded', function() {
    const selectAllCheckbox = document.getElementById('select-all');
    const itemCheckboxes = document.querySelectorAll('.item-checkbox');
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const removeButtons = document.querySelectorAll('.btn-remove');
    const totalPriceElement = document.querySelector('.price'); // 确保这个选择器与页面中的元素匹配

    // 假设每个商品的价格为99元
    const itemPrice = 99;

    // 计算总价
    function calculateTotal() {
        let total = 0;
        itemCheckboxes.forEach((checkbox, index) => {
            const quantity = parseInt(quantityInputs[index].value, 10) || 0;
            if (checkbox.checked) {
                total += itemPrice * quantity;
            }
        });
        totalPriceElement.textContent = `￥${total.toFixed(2)}`;
    }

    // 单项选择
    var check = document.getElementById("checkbox1")
    itemCheckboxes.forEach(checkbox => {
        check.addEventListener('change', calculateTotal);
    });


    // 删除商品按钮事件监听器
    removeButtons.forEach(button => {
        button.addEventListener('click', function() {
            // 找到按钮所在的商品项
            const itemRow = button.closest('.item-details'); // 根据实际的类名调整选择器
            if (!itemRow) return;

            // 假设每个商品项有data-id属性，包含商品的唯一标识符
            const itemId = itemRow.dataset.id;
            if (!itemId) return;

            // 发送请求到后端删除商品
            fetch('/delete-from-cart-url', { // 替换为实际的URL
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({itemId: itemId})
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 如果删除成功，从页面上删除商品项
                        itemRow.remove();
                        // 重新计算总价
                        calculateTotal();
                        // 弹出删除成功的提示
                        alert('商品已成功从购物车删除！');
                    } else {
                        // 处理删除失败的情况
                        console.error('删除商品失败:', data.message);
                        alert('删除商品失败，请稍后重试。');
                    }
                })
                .catch(error => {
                    // 处理网络或其他错误
                    console.error('删除商品时发生错误:', error);
                    alert('删除商品时发生错误，请稍后重试。');
                });
        });
    });

    const favoriteButton = document.querySelector('.btn-favorite');
    favoriteButton.addEventListener('click', function() {
        // 找到所有被选中的商品项的复选框
        const selectedItems = document.querySelectorAll('.item-checkbox:checked');

        if (selectedItems.length === 0) {
            alert('请选择要移入收藏夹的商品');
            return;
        }

        // 存储商品ID的数组，用于发送请求
        const itemIds = Array.from(selectedItems).map(checkbox => checkbox.dataset.itemId);

        // 使用Promise.all来处理并发请求
        Promise.all(
            itemIds.map(itemId => addToFavorite(itemId))
        ).then(results => {
            // 所有请求完成后的处理
            alert('商品已成功添加到收藏夹！');
            // 可以根据需要在这里更新页面或给用户其他反馈
        }).catch(error => {
            // 请求失败的处理
            console.error('添加到收藏夹时发生错误:', error);
            alert('移入到收藏夹失败，请稍后重试。');
        });
    });

    // 初始化计算总价
    calculateTotal();

});
