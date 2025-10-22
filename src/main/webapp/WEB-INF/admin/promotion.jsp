<%-- 
    Document   : promotion
    Created on : Oct 19, 2025, 12:53:25?PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/header.jsp" %>

<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Promotion Management</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">Home page</a></li>
                        <li class="tg-active">Promotion</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid mt-4">
    <!-- Tiêu đề trang -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <button class="btn btn-primary m-5" data-toggle="modal" data-target="#addPromoModal">
            Thêm khuyến mãi
        </button>
    </div>

    <!-- Thanh công cụ -->
    <div class="card mb-4">
        <div class="card-body">
            <form class="form-inline">
                <input type="text" class="form-control mr-2 mb-2 mb-sm-0" placeholder="Tìm kiếm khuyến mãi...">
                <select class="form-control mr-2 mb-2 mb-sm-0">
                    <option>Tất cả</option>
                    <option>Đang diễn ra</option>    
                    <option>Đã kết thúc</option>
                </select>
                <button type="submit" class="btn btn-outline-secondary">
                    <i class="fa fa-search">Tìm</i> 
                </button>
            </form>
        </div>
    </div>

    <!-- Bảng danh sách khuyến mãi -->
    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0">
                    <thead class="thead-light">
                        <tr>

                            <th>Mã KM</th>
                            <th>Giảm (%)</th>
                            <th>description</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>

                            <th>Trạng thái</th>
                            <th >Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pro" items="${list}">
                            <tr>      
                                <td>${pro.code}</td>
                                <td>${pro.discount}</td>
                                <td>${pro.description}</td>
                                <td><fmt:formatDate value="${pro.startDay}" pattern="dd-MM-yyyy"/></td>
                                <td><fmt:formatDate value="${pro.endDay}" pattern="dd-MM-yyyy"/></td>
                                <c:choose>
                                    <c:when test="${pro.status == 1}">
                                        <td class="bg-success text-white">Đang diễn ra</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="bg-danger text-white">Đã diễn ra</td>
                                    </c:otherwise>
                                </c:choose>
                                <td class="text-center">

                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#editModal" >Edit</button>

                                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" >Delete</button>
                                </td>

                            </tr>
                        </c:forEach>
                        <!-- Dòng khác -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pager">
            <li>
                <a href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li><a >1</a></li>
            <li><a >2</a></li>
            <li><a >3</a></li>
            <li><a >4</a></li>
            <li><a >5</a></li>
            <li>
                <a href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
</div>

<!-- Modal thêm khuyến mãi -->
<div class="modal fade" id="addPromoModal" tabindex="-1" role="dialog" aria-labelledby="addPromoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <form>
                <div class="modal-header">
                    <h5 class="modal-title" id="addPromoModalLabel">Thêm khuyến mãi mới</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label>Tên chương trình</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>Mã khuyến mãi</label>
                            <input type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>Loại khuyến mãi</label>
                            <select class="form-control">
                                <option>Theo %</option>
                                <option>Theo số tiền</option>
                                <option>Mua X tặng Y</option>
                            </select>
                        </div>
                        <div class="form-group col-md-4">
                            <label>Ngày bắt đầu</label>
                            <input type="date" class="form-control">
                        </div>
                        <div class="form-group col-md-4">
                            <label>Ngày kết thúc</label>
                            <input type="date" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Giá trị giảm</label>
                        <input type="number" class="form-control" placeholder="Nhập % hoặc số tiền giảm">
                    </div>
                    <div class="form-group">
                        <label>Sản phẩm áp dụng</label>
                        <input type="text" class="form-control" placeholder="Nhập tên hoặc mã sản phẩm...">
                    </div>
                    <div class="form-group">
                        <label>Mô tả</label>
                        <textarea class="form-control" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>




<%@include file="/WEB-INF/includes/footer.jsp" %>