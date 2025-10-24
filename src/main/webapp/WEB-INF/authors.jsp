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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/icomoon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jquery-ui.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.carousel.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/transitions.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/color.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
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
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal_add"
                            style="margin-bottom: 10px;">Thêm tác giả mới
                    </button>

                    <table class="table table-bordered">
                        <thead>
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
                                <tr class="active-row">
                                    <td>${loop.index + 1}</td>
                                    <td>${author.name}</td>
                                    <td style="max-width: 160px;">${author.bio}</td>
                                    <td>${author.bookcount}</td>
                                    <td>${author.created_at}</td>
                                    <td>${author.updated_at}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning" data-toggle="modal"
                                                data-target="#myModal_edit${author.id}">Sửa
                                        </button>
                                        <button type="button" class="btn btn-danger" data-toggle="modal"
                                                data-target="#myModal_delete${author.id}">Xóa
                                        </button>
                                    </td>
                                </tr>


                                <!-- Modal edit -->
                            <div class="modal fade" id="myModal_edit${author.id}" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <form action="${pageContext.request.contextPath}/edit-author" method="post">
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
                                                    <textarea name="description" class="form-control" required>${author.bio}</textarea>
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
                                        <form action="${pageContext.request.contextPath}/delete-author" method="get">
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

                </div>
            </div>
        </main>

        <!-- Modal add -->
        <div class="modal fade" id="myModal_add" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/create-author" method="post">
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
                                <input name="description" type="text" class="form-control" required>
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
        <script src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

    </body>
</html>
