<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../includes/headerTotal.jsp" %>

<!--************************************
                Inner Banner Start
*************************************-->
<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100"
     data-appear-top-offset="600"
     data-parallax="scroll"
     data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Cart information</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="index.jsp">Home Page</a></li>
                        <li class="tg-active">Cart</li>
                            <%-- <li class="tg-active">Chi tiết đơn hàng</li> --%>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<!--************************************
                Order Information Start
*************************************-->
<div class="tg-sectionspace tg-haslayout" style="padding-top: 50px;">
    <div class="container">
        <div class="row">
            <form action="${pageContext.request.contextPath}/orders" method="post">
                <input type="hidden" name="action" value="confirm">
                <div id="tg-twocolumns" class="tg-twocolumns">

                    <!-- Right Column: Order Info -->
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 pull-right">
                        <div id="tg-content" class="tg-content">
                            <h2>Order Information</h2>
                            <table class="table table-bordered">
                                <tr>
                                    <th>NO.</th>
                                    <th>Book Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Provisional</th>
                                </tr>

                                <c:forEach var="item" items="${cartList}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${item.product.bookName}</td>
                                        <td>${item.quantity}</td>
                                        <td>${item.product.price} $</td>
                                        <td>${item.product.price * item.quantity} $</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>

                        <tr>
                            <td colspan="7">
                                <h5 style="color: black; text-align: left; font-family: 'Arial', sans-serif; font-size: 18px; font-weight: bold;">
                                    Total :
                                    <span style="color: green;">${total} $</span>
                                    <input type="hidden" name="total" value="${total}">
                                </h5>

                            </td>
                        </tr>
                    </div>

                    <!-- Left Column: Customer Info -->
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-5 pull-left">
                        <div>
                            <h2>Fill in your information</h2>
                        </div>

                        <div class="form-group">
                            <label><span style="color: red;">*</span><strong>Full Name</strong></label>
                            <input name="fullname" type="text" class="form-control" style="width: 500px;" required>
                        </div>
                        <div class="form-group">
                            <label><span style="color: red;">*</span><strong>Phone</strong></label>
                            <input name="phone" type="text" class="form-control" style="width: 500px;" required>
                        </div>

                        <div class="form-group">
                            <label><span style="color: red;">*</span><strong>Address</strong></label>
                            <input name="address" type="text" class="form-control" style="width: 500px;" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="background: green; width: 200px;" id="confirm_btn">
                            Order Confirmation
                        </button>                  
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const fullnameInput = document.querySelector('input[name="fullname"]');
        const phoneInput = document.querySelector('input[name="phone"]');
        const addressInput = document.querySelector('input[name="address"]');
        const form = document.querySelector("form");

        // Thêm vùng hiển thị lỗi ngay sau input
        fullnameInput.insertAdjacentHTML('afterend', '<span id="nameError" style="color:red; font-size:14px;"></span>');
        phoneInput.insertAdjacentHTML('afterend', '<span id="phoneError" style="color:red; font-size:14px;"></span>');
        addressInput.insertAdjacentHTML('afterend', '<span id="addressError" style="color:red; font-size:14px;"></span>');

        const nameError = document.getElementById("nameError");
        const phoneError = document.getElementById("phoneError");
        const addressError = document.getElementById("addressError");

        const nameRegex = /^([A-Z][a-z]+)(\s[A-Z][a-z]+)*$/;
        const phoneRegex = /^0[1-9][0-9]{8}$/;
        const addressRegex = /^(?!.*[.,#/^()'\-]{2,})(?!-)[A-Za-z0-9\s.,#/^()'\-]{2,50}$/;

        // Hàm kiểm tra từng trường
        function validateName() {
            const value = fullnameInput.value.trim();
            if (!value) {
                nameError.textContent = "Please enter your full name!";
                return false;
            } else if (!nameRegex.test(value)) {
                nameError.textContent = "Invalid name! (e.g. Tinh, Le Tinh, Le Van Tinh)";
                return false;
            } else {
                nameError.textContent = "";
                return true;
            }
        }

        function validatePhone() {
            const value = phoneInput.value.trim();
            if (!value) {
                phoneError.textContent = "Vui lòng nhập số điện thoại!";
                return false;
            } else if (!phoneRegex.test(value)) {
                phoneError.textContent = "Please enter a 10-digit Phone Number, starting with 0 and the second digit not being 0!";
                return false;
            } else {
                phoneError.textContent = "";
                return true;
            }
        }

        function validateAddress() {
            const value = addressInput.value.trim();
            if (!value) {
                addressError.textContent = "Please enter shipping address!";
                return false;
            } else if (!addressRegex.test(value)) {
                addressError.textContent = "Invalid address! (Example: 123 Nguyen Trai, District 1, HCMC)";
                return false;
            } else {
                addressError.textContent = "";
                return true;
            }
        }

        // Gắn sự kiện realtime khi nhập
        fullnameInput.addEventListener("input", validateName);
        phoneInput.addEventListener("input", validatePhone);
        addressInput.addEventListener("input", validateAddress);

        // Kiểm tra lại khi submit
        form.addEventListener("submit", function (e) {
            const validName = validateName();
            const validPhone = validatePhone();
            const validAddress = validateAddress();

            if (!validName || !validPhone || !validAddress) {
                e.preventDefault(); // Ngăn submit nếu có lỗi
            }
        });
    });
</script>





<%@include file="../includes/footer.jsp" %>