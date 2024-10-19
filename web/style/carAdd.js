document.addEventListener('DOMContentLoaded', function() {
    const decreaseButtons = document.querySelectorAll('.btn-decrease');
    const increaseButtons = document.querySelectorAll('.btn-increase');
    const quantityInputs = document.querySelectorAll('.quantity-input');

    decreaseButtons.forEach(button => {
        button.addEventListener('click', function() {
            let quantityInput = this.nextElementSibling;
            let currentQuantity = parseInt(quantityInput.value, 10);
            if (currentQuantity > 1) {
                quantityInput.value = currentQuantity - 1;
            }
        });
    });

    increaseButtons.forEach(button => {
        button.addEventListener('click', function() {
            let quantityInput = this.previousElementSibling;
            let currentQuantity = parseInt(quantityInput.value, 10);
            quantityInput.value = currentQuantity + 1;
        });
    });
});