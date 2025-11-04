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
            <form action="confirm" method="post">
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

                                <c:forEach var="item" items="${listCartItem}" varStatus="status">
                                    <tr class="active-row">
                                           <td>${count}</td>
                                                    <td>${item.getProduct().bookName}</td>
                                                    <td><img src="${item.getProduct().img}" alt="image description" style="height: 100px;"></td>
                                                    <td style="font-size : 15px"></td>
                                                    <td class="tg-quantityholder">
                                                        <em class="minus">-</em>
                                                        <input type="text" value="${item.quantity}" class="quan" data-max="${item.getProduct().quantity}" data-sku="${item.sku}" data-price="${item.getProduct().price}" style="width: 80px; margin-top: 5px;">

                                                        <em class="plus">+</em>

                                                    </td>
                                                    <td class="total">${item.quantity * item.getProduct().price} $</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>

                        <tr>
                            <td colspan="7">
                                <h5 style="color: black; text-align: left;">
                                    Tổng tiền :
                                    <span style="color: green;">${cartInfo.amount} $</span>
                                </h5>
                            </td>
                        </tr>
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