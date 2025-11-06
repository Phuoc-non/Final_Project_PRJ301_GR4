<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/includes/headerTotal.jsp" />


    <body>
        <header id="tg-header" class="tg-header tg-haslayout">

        </header>

        <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" 
             data-z-index="-100" data-appear-top-offset="600" 
             data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
            <div class="container">
                <div class="tg-innerbannercontent">
                    <h1>Quản lý đơn hàng</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="#">Trang chủ</a></li>
                        <li class="tg-active">Đơn hàng</li>
                    </ol>
                </div>
            </div>
        </div>

        <main id="tg-main" class="tg-main tg-haslayout">
            <div class="tg-sectionspace tg-haslayout" style="padding-top: 50px;">
                <div class="container">
                    <div class="tg-products">
                        <div class="tg-productgrid">
                            <div class="row">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã đơn</th>
                                            <th>Họ và tên</th>
                                            <th>Số điện thoại</th>
                                            <th>Địa chỉ</th>
                                            <th>Tổng tiền</th>
                                            <th>Ngày tạo</th>
                                            <th>Ngày cập nhật</th>
                                            <th>Trạng thái</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orderList}" varStatus="st">
                                            <tr class="active-row">
                                                <td>${st.index + 1}</td>
                                                <td>${order.id}</td>
                                                <td>${order.name}</td>
                                                <td>${order.phone}</td>
                                                <td>${order.address}</td>
                                                <td>${order.total}</td>
                                                <td><fmt:formatDate value="${order.datebuy}" pattern="dd/MM/yyyy" /></td>
                                                <td><fmt:formatDate value="${order.updated_at}" pattern="dd/MM/yyyy" /></td>
                                                <td>${order.status}</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/orderdetails?id=${order.id}" class="btn btn-sm btn-primary"> Chi tiết</a>
                                                    <c:choose>
                                                        <%-- Nếu là admin --%>
                                                        <c:when test="${sessionScope.user != null && sessionScope.user.isIsAdmin()}">
                                                            <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#edit${order.id}">Sửa</button>
                                                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#delete${order.id}">Xóa</button>
                                                        </c:when>

                                                        <%-- Nếu là user thường --%>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#delete${order.id}">Xóa</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>

                                            <!-- Modal Delete -->                           
                                        <div class="modal fade" id="delete${order.id}" tabindex="-1" role="dialog">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <form action="${pageContext.request.contextPath}/orders" method="post">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${order.id}">
                                                        <c:choose>
                                                            <c:when test="${order.status eq 'Đang giao'}">
                                                                <div class="modal-header">
                                                                    <h4>Không thể xóa đơn hàng đang giao!</h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="modal-header">
                                                                    <h4>Bạn chắc chắn muốn xóa đơn hàng này?</h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                                                                    <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>


                                        <!-- Modal Edit -->
                                        <div class="modal fade" id="edit${order.id}" tabindex="-1" role="dialog">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4>Bạn muốn sửa đơn hàng này?</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="${pageContext.request.contextPath}/orders" method="post">
                                                            <input type="hidden" name="action" value="edit">
                                                            <input type="hidden" name="id" value="${order.id}">
                                                            <div class="form-group">
                                                                <label>Trạng thái</label>
                                                                <select name="status" class="form-control" required>
                                                                    <option ${order.status eq 'Duyệt' ? 'selected' : ''}>Duyệt</option>
                                                                    <option ${order.status eq 'Đang giao' ? 'selected' : ''}>Đang giao</option>
                                                                    <option ${order.status eq 'Thành công' ? 'selected' : ''}>Thành công</option>
                                                                    <option ${order.status eq 'Hủy' ? 'selected' : ''}>Hủy</option>
                                                                </select>
                                                            </div>
                                                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pager">
                            <li><a href="?page=1">1</a></li>
                            <li><a href="?page=2">2</a></li>
                            <li><a href="?page=3">3</a></li>
                            <li><a href="?page=4">4</a></li>
                            <li><a href="?page=5">5</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>



        <%@include file="../includes/footer.jsp" %>