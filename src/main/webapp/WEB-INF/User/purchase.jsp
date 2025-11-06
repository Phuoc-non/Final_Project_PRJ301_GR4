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
                    <h1 style="margin-bottom: 20px;">Thông tin đặt hàng</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="index.jsp">Trang chủ</a></li>
                        <li class="tg-active">Giỏ hàng</li>
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
                            <h2>Thông tin đơn hàng</h2>
                            <table class="table table-bordered">
                                <tr>
                                    <th>STT</th>
                                    <th>Tên sách</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá</th>
                                    <th>Tạm tính</th>
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


                        <div class="form-group" style="margin-top: 10px;">
                            <label for="discount" style="font-weight: bold; color: black;">Chọn mã giảm giá:</label>

                            <div style="display: flex; align-items: center; gap: 10px;">
                                <select id="discount" name="discount" class="form-control" style="width: 50%;">
                                    <option value="0" data-percent="0">Không áp dụng</option>

                                    <c:forEach items="${listP}" var="p">  
                                        <c:choose>
                                           
                                            <c:when test="${total >= p.minOrderValue}">
                                                <option value="${p.code}" 
                                                        data-percent="${p.discount}" 
                                                        data-min="${p.minOrderValue}"
                                                         style="background-color: #e6ffe6; color: black;">>
                                                    ${p.code} - Giảm ${p.discount}% (ĐH từ ${p.minOrderValue}$)
                                                </option>
                                            </c:when>

                                         
                                            <c:otherwise>
                                                <option value="${p.code}" 
                                                        data-percent="${p.discount}" 
                                                        data-min="${p.minOrderValue}" 
                                                        disabled
                                                         style="background-color: #f5f5f5; color: gray;">
                                                    ${p.code} - Giảm ${p.discount}% (Cần ${p.minOrderValue}$, chưa đủ)
                                                </option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>

                                <!-- Ô hiển thị phần trăm giảm -->
                                <input type="text" id="discount-display" class="form-control" 
                                       style="width: 100px; text-align: center; font-weight: bold;" 
                                       value="0%" readonly>
                            </div>
                        </div>

                        <!-- Hiển thị tổng tiền -->
                        <h5 style="color: black; text-align: left; font-family: 'Arial', sans-serif; font-size: 18px; font-weight: bold; margin-top: 15px;">
                            Tổng tiền :
                            <!-- Giá gốc -->
                            <span id="old-total" style="text-decoration: none; color: green;">
                                ${total} $
                            </span>

                            <!-- Giá sau giảm -->
                            <span id="discounted-total" style="color: green; font-weight: bold; display: none; margin-left: 10px;">
                                ${total} $
                            </span>

                            <input type="hidden" id="total-hidden" name="total" value="${total}">
                        </h5>

                        <script>
                            document.getElementById("discount").addEventListener("change", function () {
                                const selected = this.options[this.selectedIndex];
                                const percent = parseFloat(selected.getAttribute("data-percent")) || 0;
                                const total = parseFloat("${total}");
                                const minOrder = parseFloat(selected.getAttribute("data-min")) || 0;

                                const oldTotalEl = document.getElementById("old-total");
                                const discountedEl = document.getElementById("discounted-total");
                                const discountDisplay = document.getElementById("discount-display");

                                // Nếu chưa đủ minOrder (phòng trường hợp JS chỉnh option enable)
                                if (total < minOrder && percent > 0) {
                                    alert("Đơn hàng chưa đủ " + minOrder + "$ để dùng mã này!");
                                    this.value = "0"; // reset lại
                                    oldTotalEl.style.textDecoration = "none";
                                    oldTotalEl.style.color = "green";
                                    discountedEl.style.display = "none";
                                    discountDisplay.value = "0%";
                                    document.getElementById("total-hidden").value = total.toFixed(2);
                                    return;
                                }

                                // Tính toán giảm giá
                                const discountAmount = total * percent / 100;
                                const newTotal = total - discountAmount;

                                if (percent > 0) {
                                    // Gạch ngang giá cũ
                                    oldTotalEl.style.textDecoration = "line-through";
                                    oldTotalEl.style.color = "gray";
                                    // Hiển thị giá mới
                                    discountedEl.style.display = "inline";
                                    discountedEl.innerText = newTotal.toFixed(2) + " $";
                                    discountDisplay.value = percent + "%";
                                } else {
                                    oldTotalEl.style.textDecoration = "none";
                                    oldTotalEl.style.color = "green";
                                    discountedEl.style.display = "none";
                                    discountDisplay.value = "0%";
                                }

                                // Cập nhật giá trị ẩn để submit form
                                document.getElementById("total-hidden").value = newTotal.toFixed(2);
                            });
                        </script>





                    </div>

                    <!-- Left Column: Customer Info -->
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-5 pull-left">
                        <div>
                            <h2>Điền thông tin của bạn</h2>
                        </div>

                        <div class="form-group">
                            <label><span style="color: red;">*</span><strong>Họ và tên</strong></label>
                            <input name="fullname" type="text" class="form-control" style="width: 500px;" required>
                        </div>
                        <div class="form-group">
                            <label><span style="color: red;">*</span><strong>Số điện thoại</strong></label>
                            <input name="phone" type="text" class="form-control" style="width: 500px;" required>
                        </div>

                        <div class="form-group">
                            <label><span style="color: red;">*</span><strong>Địa chỉ giao hàng</strong></label>
                            <input name="address" type="text" class="form-control" style="width: 500px;" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="background: green; width: 200px;" id="confirm_btn">
                            Xác nhận đơn đặt hàng
                        </button>                  
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp" %>