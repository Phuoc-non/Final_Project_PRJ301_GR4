<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="includes/headerTotal.jsp" %>


<!-- 🧩 Hiển thị thông báo lỗi từ Servlet -->
<c:if test="${not empty errorMessage}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: '${errorMessage}',
            confirmButtonText: 'Close',
            confirmButtonColor: '#d33'
        });
    </script>
</c:if>

<!-- 🧩 Hiển thị thông báo thành công -->
<c:if test="${not empty successMessage}">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success',
            text: '${successMessage}',
            confirmButtonText: 'OK',
            confirmButtonColor: '#3085d6'
        });
    </script>
</c:if>

<!-- Banner -->
<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll"
     data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg"
     style="width:100%; background-size:cover; background-position:center;">
    <div class="container text-center">
        <div class="row">
            <div class="col-xs-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Customer Management</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">Home</a></li>
                        <li class="tg-active">Customer</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<main id="tg-main" class="tg-main tg-haslayout">
    <div class="tg-sectionspace tg-haslayout" style="padding-top: 50px;">
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div id="tg-content" class="tg-content">
                        <div class="tg-products">
                            <div class="tg-productgrid">
                                <div class="row">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Full name</th>
                                                <th>Username</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>Address</th>
                                                <th>Order number</th>
                                                <th>Date created</th>
                                                <th style="width: 200px;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty reports}">
                                                <tr>
                                                    <td colspan="9" class="text-center">No customer data.</td>
                                                </tr>
                                            </c:if>
                                            <c:forEach var="p" items="${reports}">
                                                <tr class="active-row">
                                                    <td>${p.registration.id}</td>
                                                    <td>${p.registration.full_name}</td>
                                                    <td>${p.registration.username}</td>
                                                    <td>${p.phone}</td>
                                                    <td>${p.registration.email}</td>
                                                    <td>${p.registration.address}</td>
                                                    <td>${p.totalQuantity}</td>
                                                    
                                                    <td><fmt:formatDate value="${p.datebuy}" pattern="dd/MM/yyyy"/></td>
                                                    <td>
                                                        <a href="<c:url value='/cutomer?view=edit-user&id=${p.registration.id}'/>"
                                                           style="width: 60px;" class="btn btn-warning"> <i class="fa-solid fa-eye"></i></a>
                                                           <button type="button" class="btn btn-danger" style="width: 60px;"
                                                                data-toggle="modal"
                                                                data-target="#myModal_delete${p.registration.id}">
                                                            <i class="fa fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal xác nhận xóa -->
        <c:forEach var="p" items="${reports}">
            <div class="modal fade" id="myModal_delete${p.registration.id}" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title">Are you sure you want to delete this customer?</h4>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <a href="<c:url value='/cutomer?view=delete-user&id=${p.registration.id}'/>"
                               class="btn btn-primary">Yes</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <style>
            /* 🌿 Pagination Style */
            .pagination {
                display: flex;
                justify-content: center;
                gap: 8px;
                list-style: none;
                padding-left: 0;
                margin-top: 30px;
            }

            .pagination .page-item {
                display: inline-block;
            }

            .pagination .page-link {
                color: #4CAF50; /* Xanh lá */
                border: 1px solid #d9d9d9;
                border-radius: 50%; /* Làm tròn */
                padding: 8px 15px;
                text-decoration: none;
                background-color: #fff;
                transition: all 0.2s ease-in-out;
                font-weight: 500;
            }

            /* Hover effect */
            .pagination .page-link:hover {
                background-color: #e9f5ec; /* Màu nền xanh nhạt */
                border-color: #4CAF50;
                color: #4CAF50;
            }

            /* Active page */
            .pagination .active .page-link {
                background-color: #4CAF50;
                color: #fff;
                border-color: #4CAF50;
            }

            /* Disabled button */
            .pagination .disabled .page-link {
                color: #ccc;
                pointer-events: none;
                border-color: #eee;
            }
        </style>

        <!-- 🌿 Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <!-- Previous button -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link"
                       href="<c:url value='/cutomer'><c:param name='page' value='${currentPage - 1}'/></c:url>"
                           aria-label="Previous">
                           &laquo;
                       </a>
                    </li>

                    <!-- Page numbers -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link"
                           href="<c:url value='/cutomer'><c:param name='page' value='${i}'/></c:url>">
                            ${i}
                        </a>
                    </li>
                </c:forEach>

                <!-- Next button -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link"
                       href="<c:url value='/cutomer'><c:param name='page' value='${currentPage + 1}'/></c:url>"
                           aria-label="Next">
                           &raquo;
                       </a>
                    </li>
                </ul>
            </nav>
        </div>
    </main>

                       <%@include file="../WEB-INF/includes/footer.jsp" %>
