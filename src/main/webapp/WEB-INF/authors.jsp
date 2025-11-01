<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../WEB-INF/includes/headerTotal.jsp"/>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Book Library | Quản lý tác giả - Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/assets/apple-touch-icon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/color.css">
    </head>

    <body>

        <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
             data-z-index="-100"
             data-appear-top-offset="600"
             data-parallax="scroll"
             data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="tg-innerbannercontent">
                            <h1 style="margin-bottom: 20px;">Quản lý tác giả</h1>
                            <ol class="tg-breadcrumb">
                                <li><a href="#">Trang chủ</a></li>
                                <li class="tg-active">Tác giả</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <main id="tg-main" class="tg-main tg-haslayout">
            <div class="tg-sectionspace tg-haslayout" style="padding-top: 50px;">
                <div class="container">

                    <!-- 🧩 Nút thêm + tiêu đề -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="m-0">Danh sách tác giả</h2>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal_add">
                            + Thêm tác giả mới
                        </button>
                    </div>

                    <!-- 🧩 Bảng danh sách -->
                    <table class="table table-bordered text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>STT</th>
                                <th>Tên tác giả</th>
                                <th>Miêu tả</th>
                                <th>Số lượng sách</th>
                                <th>Ngày tạo</th>
                                <th>Ngày cập nhật</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="author" items="${authorList}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${author.name}</td>
                                    <td style="max-width:160px;">${author.bio}</td>
                                    <td>${author.bookcount}</td>
                                    <td><fmt:formatDate value="${author.created_at}" pattern="dd/MM/yyyy" /></td>
                                    <td><fmt:formatDate value="${author.updated_at}" pattern="dd/MM/yyyy" /></td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#myModal_edit${author.id}">Sửa</button>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal_delete${author.id}">Xóa</button>
                                    </td>
                                </tr>

                                <!-- Modal edit -->
                            <div class="modal fade" id="myModal_edit${author.id}" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <form action="${pageContext.request.contextPath}/authors" method="post">
                                            <input type="hidden" name="action" value="edit">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Sửa tác giả</h4>
                                            </div>
                                            <div class="modal-body">
                                                <input type="hidden" name="id" value="${author.id}">
                                                <div class="form-group">
                                                    <label>Tên tác giả</label>
                                                    <input type="text" name="name" value="${author.name}" class="form-control" required>
                                                </div>
                                                <div class="form-group">
                                                    <label>Miêu tả</label>
                                                    <textarea name="bio" class="form-control" required>${author.bio}</textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-primary">Lưu</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal delete -->
                            <div class="modal fade" id="myModal_delete${author.id}" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <form action="${pageContext.request.contextPath}/authors" method="post">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${author.id}">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Bạn chắc chắn muốn xóa tác giả này?</h4>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-danger">Xác nhận</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                    <!-- 🌿 CSS phân trang -->
        <style>
            .pagination {
                display: flex;
                justify-content: center;
                gap: 8px;
                list-style: none;
                padding-left: 0;
                margin-top: 30px;
            }
            .pagination .page-link {
                color: #4CAF50;
                border: 1px solid #d9d9d9;
                border-radius: 50%;
                padding: 8px 15px;
                text-decoration: none;
                background-color: #fff;
                transition: all 0.2s ease-in-out;
                font-weight: 500;
            }
            .pagination .page-link:hover {
                background-color: #e9f5ec;
                border-color: #4CAF50;
                color: #4CAF50;
            }
            .pagination .active .page-link {
                background-color: #4CAF50;
                color: #fff;
                border-color: #4CAF50;
            }
            .pagination .disabled .page-link {
                color: #ccc;
                pointer-events: none;
                border-color: #eee;
            }
        </style>
        <!-- 🌿 Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <!-- Nút Previous -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link"
                       href="<c:url value='/authors'><c:param name='page' value='${currentPage - 1}'/></c:url>"
                           aria-label="Previous">&laquo;</a>
                    </li>

                    <!-- Các số trang -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link"
                           href="<c:url value='/authors'><c:param name='page' value='${i}'/></c:url>">${i}</a>
                        </li>
                </c:forEach>

                <!-- Nút Next -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link"
                       href="<c:url value='/authors'><c:param name='page' value='${currentPage + 1}'/></c:url>"
                           aria-label="Next">&raquo;</a>
                    </li>
                </ul>
            </nav>
                </div>
            </div>
        </main>

        <!-- Modal add -->
        <div class="modal fade" id="myModal_add" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/authors" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="modal-header">
                            <h4 class="modal-title">Thêm tác giả mới</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Tên tác giả</label>
                                <input name="name" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Miêu tả</label>
                                <input name="bio" type="text" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-library.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/vendor/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

    </body>
</html>
