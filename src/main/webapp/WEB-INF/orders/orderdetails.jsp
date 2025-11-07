<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/headerTotal.jsp" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll"
     data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Order information</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="home.jsp">Home Page</a></li>
                        <li class="tg-active">Order</li>
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
                        <h2>Book already booked</h2>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>NO.</th>
                                    <th>Book Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Provisional</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="oldTotal" value="0" />
                            <c:forEach var="detail" items="${orderDetails}" varStatus="loop">
                                <tr>
                                    
                                    <td>${loop.index + 1}</td>
                                    <td>${detail.productName}</td>
                                    <td>${detail.quantity}</td>
                                    <td>${detail.price} $</td>
                                    <td>${detail.subTotal} $</td>
                                </tr>
                                  <c:set var="oldTotal" value="${oldTotal + detail.subTotal}" />
                            </c:forEach>
                            </tbody>
                        </table>
                        
                         <h5 style="color: black; text-align: left; font-family: 'Arial', sans-serif; font-size: 18px; font-weight: bold; margin-top: 15px;">  
                                Tổng giá gốc :
                            <!-- Giá gốc -->
                            <span id="old-total" style="text-decoration: none; color: green;">
                               ${oldTotal} $
                            </span>
                         </h5>
                    </div>
                </div>

                <!-- Thông tin Đơn hàng -->
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4 pull-left">
                    <h2>Orders</h2>
                    <table class="styled-table">
                        <tr>
                            <th>ID</th>
                            <td>${order.id}</td>
                        </tr>
                        <tr>
                            <th>Full name</th>
                            <td>${order.name}</td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td>${order.phone}</td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td>${order.address}</td>
                        </tr>
                        <tr>
                            <th>Ngày đặt</th>
                                     <td><fmt:formatDate value="${order.datebuy}" pattern="dd/MM/yyyy" /></td>
                        </tr>
                        <tr>
                            <th>Giá sau giảm</th>
                            <td>${order.total} $</td>
                        </tr>
                        <tr>
                            <th>Status</th>
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
                    Are you sure you want to delete this order?
                </h4>
            </div>
            <div class="modal-body">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a href="deleteOrder?id=${order.id}" class="btn btn-primary">Confirm</a>
            </div>
        </div>
    </div>
</div>



                <%@include file="../includes/footer.jsp" %>