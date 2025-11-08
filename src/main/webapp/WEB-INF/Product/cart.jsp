<%-- 
Document   : productdetail
Created on : Oct 15, 2025, 2:33:11 PM
Author     : Asus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/headerTotal.jsp" %>

<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100"
     data-appear-top-offset="600"
     data-parallax="scroll"
     data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg">

    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1>All Products</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="book">home</a></li>
                        <li><a href="ab?cate=all">Products</a></li>
                        <li class="tg-active">Cart Here</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<main id="tg-main" class="tg-main tg-haslayout">
    <div class="tg-sectionspace tg-haslayout">
        <div class="container">
            <div class="row">
                <div id="tg-twocolumns" class="tg-twocolumns">
                    <div>
                        <div>
                            <form method="post">
                                <table class="styled-table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Book name</th>
                                            <th>Image</th>
                                            <th>Selling price</th>
                                            <th>Quantity</th>
                                            <th>Total</th> 
                                            <th>Action</th>                                         
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="count" value="0" scope="page"/> 
                                        <c:forEach var="item" items="${listCartItem}">
                                            <c:set var="count" value="${count + 1}" scope="page"/> 
                                            <tr class="active-row">
                                                <td>${count}</td>
                                                <td>${item.getProduct().bookName}</td>
                                                <td><img src="${item.getProduct().img}" alt="image" style="height: 100px;"></td>
                                                <td style="font-size:15px;">${item.getProduct().price} $</td>
                                                <td class="tg-quantityholder" style="height: 106px">
                                                    <em class="minus">-</em>
                                                    <input type="text" value="${item.quantity}" class="quan"
                                                           data-max="${item.getProduct().quantity}"
                                                           data-sku="${item.sku}"
                                                           data-price="${item.getProduct().price}"
                                                           style="width: 80px; margin-top: 5px; ">
                                                    <em class="plus">+</em>
                                                </td>
                                                <td class="total">${item.quantity * item.getProduct().price} $</td>
                                                <td>
                                                   <a href="">
                                                            <button type="button" class="btn btn-danger delete" data-sku="${item.sku}" style="width: 80px;">
                                                                <i class="fa-solid fa-trash"></i>
                                                            </button>
                                                        </a> 
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </form>

                            <!-- Nút Đặt hàng -->
                            <c:if test="${not empty listCartItem}">
                                <div class="text-center" style="margin-top:15px;">
                                    <form action="http://localhost:8080/Lib/orders" method="get">
                                        <input type="submit" name="submit" value="orders" class="btn btn-primary">
                                        <input type="hidden" name="view" value="confirm">
                                    </form>
                                </div>
                            </c:if>

                            <!-- Giỏ hàng trống -->
                            <c:if test="${empty listCartItem}">
                                <h5 style="color:red; margin-top:10px;">Show at the empty list</h5>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>


<script>
    document.querySelector('input[value="orders"]').addEventListener('click', function (e) {
        e.preventDefault(); // Ngăn form gửi ngay

        // Thu thập dữ liệu hiện tại
        const items = [];
        document.querySelectorAll('.quan').forEach(input => {
            const sku = input.dataset.sku;
            const quantity = parseInt(input.value);
            items.push({sku, quantity});
        });

        // Gửi cập nhật lên server
        fetch('cartupdate', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(items)
        })
                .then(res => res.text())
                .then(msg => {
                    console.log('Cart updated:', msg);
                    // Sau khi cập nhật session thành công, chuyển sang trang orders
                    window.location.href = 'orders?view=confirm';
                })
                .catch(err => console.error(err));
    });
</script>

<%@include file="../includes/footer.jsp" %>
