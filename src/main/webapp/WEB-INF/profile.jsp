<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Registration"%>

<%
    Registration sessionUser = (Registration) session.getAttribute("user");
    if (sessionUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    boolean adminMode = sessionUser.isIsAdmin();
    Registration currentUser = (Registration) request.getAttribute("currentUser");
    if (currentUser == null) {
        currentUser = sessionUser;
    }

    String message = (String) request.getAttribute("message");
    String formAction = "profile"; // gửi về servlet ProfileServlet (doPost)
    String headerTitle = adminMode ? "Thông tin quản trị viên" : "Thông tin cá nhân";
    String pageTitle = adminMode ? "Chi tiết quản trị viên" : "Trang cá nhân";
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Book Library | <%= pageTitle%></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <body>
        <%@include file="../WEB-INF/headerTotal.jsp" %>

        <!-- Banner -->
        <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
             data-z-index="-100" data-parallax="scroll"
             data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg">
            <div class="container text-center">
                <h1 style="margin-bottom: 20px;"><%= headerTitle%></h1>
                <ol class="tg-breadcrumb">
                    <li><a href="home">Trang chủ</a></li>
                    <li class="active"><%= pageTitle%></li>
                </ol>
            </div>
        </div>

        <!-- Nội dung chính -->
        <main id="tg-main" class="tg-main tg-haslayout">
            <div class="tg-sectionspace tg-haslayout">
                <div class="container">
                    <form action="<%= formAction%>" method="post">
                        <input type="hidden" name="id" value="<%= currentUser.getId()%>">

                        <div class="row">
                            <!-- Cột trái -->
                            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5">
                                <h2>Thông tin cá nhân</h2>

                                <div class="form-group">
                                    <label><span style="color:red">*</span> Họ và tên</label>
                                    <input type="text" name="full_name" class="form-control"
                                           value="<%= currentUser.getFull_name()%>" id="full_name"
                                           style="width:600px;" disabled>
                                </div>

                                <div class="form-group">
                                    <label><span style="color:red">*</span> Email</label>
                                    <input type="email" name="email" class="form-control"
                                           value="<%= currentUser.getEmail()%>" id="email"
                                           style="width:600px;" disabled>
                                </div>

                               
                                <div class="form-group">
                                    <label><span style="color:red">*</span> Địa chỉ</label>
                                    <input type="text" name="address" class="form-control"
                                           value="<%= currentUser.getAddress()%>"
                                           id="address" style="width:600px;" disabled>
                                </div>
                              
                            </div>

                            <!-- Cột phải -->
                            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5">
                                <h2>Tài khoản</h2>

                                <div class="form-group">
                                    <label><span style="color:red">*</span> Username</label>
                                    <input type="text" name="username" class="form-control"
                                           value="<%= currentUser.getUsername()%>"
                                           id="username" style="width:400px;" disabled>
                                </div>

                                <div class="form-group">
                                    <label><span style="color:red">*</span> Password</label>
                                    <input type="password" name="password" class="form-control"
                                           value="<%= currentUser.getPassword()%>"
                                           id="password" style="width:400px;" disabled>
                                </div>

                                <button type="button" class="btn btn-warning" id="editPass-btn"
                                        data-toggle="modal" data-target="#myModal_edit_password">
                                    Đổi mật khẩu
                                </button>
                            </div>
                        </div>

                        <br>
                        <button type="button" class="btn btn-warning" id="edit-btn">Sửa</button>
                        <button type="submit" class="btn btn-primary" id="save-btn" style="display:none;">Lưu</button>
                    </form>
                </div>
            </div>
        </main>

        <!-- Modal đổi mật khẩu -->
        <div class="modal fade" id="myModal_edit_password" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header"><h4 class="modal-title">Đổi mật khẩu</h4></div>
                    <div class="modal-body">
                        <form action="change-password" method="POST">
                            <input type="hidden" name="username" value="<%= currentUser.getUsername()%>">
                            <div class="form-group">
                                <label>Mật khẩu cũ</label>
                                <input type="password" name="oldPassword" class="form-control" required>
                                <label>Mật khẩu mới</label>
                                <input type="password" name="newPassword" class="form-control" required>
                                <label>Xác nhận mật khẩu mới</label>
                                <input type="password" name="confirmNewPassword" class="form-control" required>
                            </div>
                            <div class="text-right">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-primary">Xác nhận</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/assets/js/vendor/jquery-library.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/vendor/bootstrap.min.js"></script>
        <script src="https://maps.google.com/maps/api/js?key=AIzaSyCR-KEWAVCn52mSdeVeTqZjtqbmVJyfSus&amp;language=en"></script>
        <script src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.vide.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/countdown.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/parallax.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/countTo.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/appear.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/gmap3.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            const editBtn = document.querySelector('#edit-btn');
            const saveBtn = document.querySelector('#save-btn');
            const nameInput = document.querySelector('#full_name');
            const emailInput = document.querySelector('#email');
            const addressInput = document.querySelector('#address');

            editBtn.addEventListener('click', function () {
                nameInput.disabled = false;
                emailInput.disabled = false;
                if (addressInput)
                    addressInput.disabled = false;
                saveBtn.style.display = 'inline-block';
                editBtn.style.display = 'none';
            });

            const message = "<%= message != null ? message : ""%>";
            if (message && message.trim() !== "") {
                Swal.fire({
                    icon: message === 'Thành công' ? 'success' : 'error',
                    title: message === 'Thành công' ? 'Lưu thay đổi thành công!' : message,
                    showConfirmButton: false,
                    timer: 2000
                });
            }
        </script>
    </body>
</html>
