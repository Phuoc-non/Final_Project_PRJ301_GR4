/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
/* global Swal */

//Thật ra nếu được thì tách ra nhiều file js cho chắc, ko thì đặc điều kiện if else
//do có class minus và plus giống nhau trừ class trong thẻ input là khác nên dặc điều kiện if else khác nhau bằng class input.


$(document).ready(function () {
    const min = 1;
    function addCartItem(sku, quantity) {
        fetch('http://localhost:8080/Lib/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                sku: sku,
                quantity: quantity,
                status: 'add'
            })
        })

//                .then(res => res.text())
//                .then(data => {
//                    alert(data);
//                });
                .then(res => res.text())
                .then(data => {
                    if (data.includes("error")) {
                        Swal.fire({
                            position: 'top',
                            icon: 'error',
                            title: "Please login to add products to cart",
                            showConfirmButton: false,
                            timer: 1500
                        });
                    } else {
                        Swal.fire({
                            position: 'top',
                            icon: 'success',
                            title: data,
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                });
    }
    ;

    $('.add').on('click', function () {
        const quantity = $('#quantity1').val();
        const sku = $(this).data("sku");
        addCartItem(sku, quantity);
    }
    );

    $('.minus').on('click', function () {

        const input = $(this).siblings('.result');
        let val = parseInt(input.val(), 10) || 0;

        if (val > min) {
            val--;
            input.val(val);
        }
    });
    // Nút cộng
    $('.plus').on('click', function () {
        const input = $(this).siblings('.result');
        const max = parseInt(input.data('max'));
        let val = parseInt(input.val(), 10) || 0;

        if (val < max) {
            val++;
            input.val(val);
        }
    });
    // Ngăn nhập ký tự không phải số + giới hạn max khi gõ
    $('.result').on('keypress', function (e) {
        const val = parseInt($(this).val(), 10) || 0;
        const max = parseInt($(this).data('max'));
        // Nếu đã đạt max hoặc gõ ký tự không phải số → chặn
        if (val >= max || e.which < 48 || e.which > 57)//e.which la nằm ngoài trong bảng ASCII
            e.preventDefault(); //chặn các hành động nằm ngoài đó
    });
    // Khi dán (paste) hoặc nhập bằng chuột → lọc lại và giới hạn max
    $('.result').on('input', function () {
        const max = parseInt($(this).data('max'));
        let val = parseInt($(this).val().replace(/[^0-9]/g, ''), 10) || 0;
        if (val > max)
            val = max;
        if (val < min)
            val = min;
        $(this).val(val);
    });
});
//-----------------------------------------------------------------------------------------------------------

//sau khi html chạy xong thì function đã sẵn sàng.
$(document).ready(function () {
    const min = 1;

    function deleteItem(sku) {
        fetch('http://localhost:8080/Lib/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                sku: sku,
                status: 'delete'
            })
        });
    }
    function updateCart(sku, quantity) {
        fetch('http://localhost:8080/Lib/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                sku: sku,
                quantity: quantity,
                status: 'update'
            })
        });
    }
    function updateRowTotal(input) {
        const price = parseFloat($(input).data('price'));
        const quantity = parseInt($(input).val(), 10) || 0;
        const total = (price * quantity).toFixed(2);
        $(input).closest('tr').find('.total').text(total + ' $');
    }

    $('.delete').on('click', function () {
        const sku = $(this).data('sku');

        deleteItem(sku);
        
    });

    // Nút trừ
    //chọn hết tất cả các phần tử minus trong trang $('.minus')
    //on('click', function () gắn event vào phần tử được chọn. Ở đây click là event
    //khi click thì sẽ thực hiện function tiếp đó.
    $('.minus').on('click', function () {//la sao
        //this đại diện cho phần tử html đang được click, ở đây là minus 
        //$(this) giúp ta gọi các hàm nhưu siblings.
        //sibling tìm các phần tử cùng cấp cha mẹ, ở đâu là quan.(Cha mẹ) Phần tử kế bên là quan đó.
        const input = $(this).siblings('.quan');//$ la gì, (this).siblings la gì
        let val = parseInt(input.val(), 10) || 0;// input.val() lấy giá trị
        const sku = input.data('sku');
        const price = input.data('price');
        //parse Int và chuyển về hệ cơ số 10, nếu ko dc thì cho = 0
        //val() dùng để lấy hoặc gán giá trị
        if (val > min) {
            val--;
            input.val(val);//input.val(val - 1) gán giá trị
            updateRowTotal(input);
            updateCart(sku, val);
        }
    });

    // Nút cộng
    $('.plus').on('click', function () {
        const input = $(this).siblings('.quan');
        const sku = input.data('sku');

        let val = parseInt(input.val(), 10) || 0;
        const max = parseInt(input.data('max'));
        if (val < max) {
            val++;
            input.val(val);
            updateCart(sku, val);
            updateRowTotal(input);
        }
    });

    // Ngăn nhập ký tự không phải số + giới hạn max khi gõ
    $('.quan').on('keypress', function (e) {//e là đối tượng sự kiện chứa thông tin về nút vừa bấm, ở đây là value rồi
        const val = parseInt($(this).val(), 10) || 0;//this la the co class la quan hien tai
        const max = parseInt($(this).data('max'));// lay từ data-max trên input
        // Nếu đã đạt max hoặc gõ ký tự không phải số → chặn
        if (val >= max || e.which < 48 || e.which > 57)//e.which la nằm ngoài trong bảng ASCII
            e.preventDefault();//chặn các hành động nằm ngoài đó
    });

    // Khi dán (paste) hoặc nhập bằng chuột → lọc lại và giới hạn max
    $('.quan').on('input', function () {
        const sku = $(this).data('sku');

        const max = parseInt($(this).data('max'));
        let val = parseInt($(this).val().replace(/[^0-9]/g, ''), 10) || 0;
        if (val > max)
            val = max;
        if (val < min)
            val = min;
        $(this).val(val);
        updateRowTotal(this);
        updateCart(sku, val);
    });
});


//-----------------------------------------------------------------------------------------------------------
$(document).ready(function () {

    function addCartItem(sku, quantity) {
        fetch('http://localhost:8080/Lib/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                status: 'add',
                sku: sku,
                quantity: quantity
                
            })
        })
//                .then(res => res.text())
//                .then(data => {
//                    alert(data);
//                });
                .then(res => res.text())
                .then(data => {
                    if (data.includes("error")) {
                        Swal.fire({
                            position: 'top',
                            icon: 'error',
                            title: "Please login to add products to cart",
                            showConfirmButton: false,
                            timer: 1500
                        });
                    } else {
                        Swal.fire({
                            position: 'top',
                            icon: 'success',
                            title: data,
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                });
    }
    $('.quan1').on('click', function () {
        const sku = $(this).data("sku");
        addCartItem(sku, 1);
    }
    );
});