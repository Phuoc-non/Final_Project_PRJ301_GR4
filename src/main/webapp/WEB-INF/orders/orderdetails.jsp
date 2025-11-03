<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/headerTotal.jsp" />


<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll"
     data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Thông tin đơn hàng</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="home.jsp">Trang chủ</a></li>
                        <li class="tg-active">Đơn hàng</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="tg-sectionspace tg-haslayout" style="padding-top: 50px;">
    <div class="container">
        <div class="row">
            <div id="tg-twocolumns" class="tg-twocolumns">

                <!-- Bảng Sách Đã Đặt -->
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-7 pull-right">
                    <div id="tg-content" class="tg-content">
                        <h2>Sách đã đặt</h2>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên sách</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá</th>
                                    <th>Tạm tính</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="detail" items="${orderDetails}" varStatus="loop">
                                <tr>
                                    
                                    <td>${loop.index + 1}</td>
                                    <td>${detail.productName}</td>
                                    <td>${detail.quantity}</td>
                                    <td>${detail.price} VNĐ</td>
                                    <td>${detail.subTotal} VNĐ</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Thông tin Đơn hàng -->
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 pull-left">
                    <h2>Đơn hàng</h2>
                    <table class="styled-table">
                        <tr>
                            <th>Mã đơn</th>
                            <td>${order.id}</td>
                        </tr>
                        <tr>
                            <th>Họ và tên</th>
                            <td>${order.name}</td>
                        </tr>
                        <tr>
                            <th>Số điện thoại</th>
                            <td>${order.phone}</td>
                        </tr>
                        <tr>
                            <th>Địa chỉ</th>
                            <td>${order.address}</td>
                        </tr>
                        <tr>
                            <th>Ngày đặt</th>
                                     <td><fmt:formatDate value="${order.datebuy}" pattern="dd/MM/yyyy" /></td>
                        </tr>
                        <tr>
                            <th>Tổng tiền</th>
                            <td>${order.total} VNĐ</td>
                        </tr>
                        <tr>
                            <th>Trạng thái</th>
                            <td>${order.status}</td>
                        </tr>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Modal xác nhận xóa -->
<div class="modal fade" id="myModal_delete" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" style="text-transform:none;">
                    Bạn chắc chắn muốn xóa đơn hàng này?
                </h4>
            </div>
            <div class="modal-body">
                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                <a href="deleteOrder?id=${order.id}" class="btn btn-primary">Xác nhận</a>
            </div>
        </div>
    </div>
</div>



                <%@include file="../footer.jsp" %>