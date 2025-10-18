<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Book Library | Thông tin Admin - Admin</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/normalize.css">
        <link rel="stylesheet" href="../assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="../assets/css/icomoon.css">
        <link rel="stylesheet" href="../assets/css/jquery-ui.css">
        <link rel="stylesheet" href="../assets/css/owl.carousel.css">
        <link rel="stylesheet" href="../assets/css/transitions.css">
        <link rel="stylesheet" href="../assets/css/main.css">
        <link rel="stylesheet" href="../assets/css/color.css">
        <link rel="stylesheet" href="../assets/css/responsive.css">
        <script src="../assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    </head>
    <body>
        <header id="tg-header" class="tg-header tg-haslayout">
            <div class="tg-topbar">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="tg-userlogin">
                                <div>
                                    <li style="list-style:none ;" class="menu-item-has-children">
                                        <a href=""> <i id="user_icon" class="fa fa-user"></i> Xin chào <span class="sr-only"></span></a>
                                        <div class="mega-menu user">
                                            <ul class="tg-themetabnav " role="tablist">
                                                <li><a href="<c:url value="/profile"/>">Trang cá nhân<span class="sr-only">(current)</span></a></li>
                                                <li><a href="<c:url value="/orders"/>">Thông tin mua hàng<span class="sr-only">(current)</span></a></li>
                                                <li><a class="tg-userlogout" href="<c:url value="/logout"/>">Đăng xuất<span class="sr-only">(current)</span></a></li>
                                            </ul>
                                    </li>
                                    <br>
                                    <a class="nav-link text" href="<c:url value="/signup"/>"
                                       style="margin-right: 30px">
                                        Đăng kí<span class="sr-only">(current)</span></a>
                                    <a class="nav-link text" href="<c:url value="/login"/>">
                                        Đăng nhập<span class="sr-only">(current)</span></a>
                                </div>
                            </div>
                            <div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tg-middlecontainer" style="padding: 10pxpx;">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <strong class="tg-logo"><a href="index-2.html"><img src="../assets/images/logo.png" alt="company name here"></a></strong>
                            <div class="tg-wishlistandcart">
                                <div class="dropdown tg-themedropdown tg-minicartdropdown">
                                    <a  id="tg-minicart" class="tg-btnthemedropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="tg-themebadge">${cartInfo.totalBooks}</span>
                                        <a href="<c:url value="/view-cart"/>"><i class="icon-cart"></i>
                                            <span style="margin-left: 10px;">Giỏ hàng</span></a>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tg-navigationarea">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <nav id="tg-nav" class="tg-nav">
                                <div class="navbar-header">
                                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#tg-navigation" aria-expanded="false">
                                        <span class="sr-only">Toggle navigation</span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                </div>
                                <div id="tg-navigation" class="collapse navbar-collapse tg-navigation">
                                    <ul>
                                        <li><a href="<c:url value="/"/>">Trang chủ</a></li>
                                        <li><a href="<c:url value="/products"/>">Sách</a></li>
                                        <li><a href="<c:url value="/manage-product"/>">Sách</a></li>
                                        <li><a href="<c:url value="/manage-category"/>">Danh mục</a></li>
                                        <li><a href="<c:url value="/manage-author"/>">Tác giả</a></li>
                                        <li><a href="<c:url value="/manage-user"/>">Khách hàng</a></li>
                                        <li><a href="<c:url value="/manage-order"/>">Đơn hàng</a></li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="tg-innerbannercontent">
                            <h1 style="margin-bottom: 20px;">Thông tin cá nhân</h1>
                            <ol class="tg-breadcrumb">
                                <li><a href="javascript:void(0);">Trang chủ</a></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <main id="tg-main" class="tg-main tg-haslayout">
            <div class="tg-sectionspace tg-haslayout">
                <div class="container" >
                    <div>
                        <form action="save-admin" method="post">
                            <input type="hidden" name="id" value="${admin.id}"/>
                            <div>
                                <div class="row" >
                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5 pull-left" >
                                        <h2>Thông tin cá nhân</h2>
                                        <div class="form-group">
                                            <label for="name" ><span style="color: red;">*</span><strong>Họ và tên</strong></label>
                                            <input type="text" name="name" value="${admin.name}" class="form-control" style="width: 600px; " id="name" disabled="disabled"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="email"><span style="color: red;">*</span><strong>Email</strong></label>
                                            <input type="text" name="email" value="${admin.account.email}" class="form-control" style="width: 600px;" id="email" disabled="disabled"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="address"><span style="color: red;">*</span><strong >Địa chỉ</strong></label>
                                            <input type="text" name="address" value="${admin.address}" class="form-control"  style="width: 600px;" id="address" disabled="disabled"/>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5 pull-right">
                                        <h2>Tài khoản</h2>
                                        <div class="form-group">
                                            <label for="username" ><span style="color: red;">*</span><strong>Username</strong></label>
                                            <input type="text" name="username" value="${admin.account.username}" class="form-control" style="width: 400px; " id="username" disabled="disabled"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="password"><span style="color: red;">*</span><strong>Password</strong></label>
                                            <input type="password" name="password" value="${admin.account.decryptedPassword}" class="form-control" style="width: 400px;" id="password" disabled="disabled"/>
                                        </div>
                                        <button type="button" class="btn btn-warning" id="editPass-btn" style="display:block;" data-toggle="modal" data-target="#myModal_edit_password">Đổi mật khẩu</button>
                                    </div>

                                </div>
                                <button type="button" class="btn btn-warning" id="edit-btn" style="display:block;">Sửa</button>

                                <button type="submit" class="btn btn-primary" id="save-btn" style="display:block;"
                                        data-toggle="modal" data-target="#myModal_save">Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <div class="modal fade" id="myModal_save" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel" style="text-transform: none;">Bạn chắc chắn muốn sửa thông tin này?</h4>
                    </div>
                    <div class="modal-body">
                        <form>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                            <button type="button" class="btn btn-primary" id="confirm_edit_btn">Xác nhận</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal_edit_password" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel" style="text-transform: none;">Xác minh đổi mật khẩu</h4>
                    </div>
                    <div class="modal-body">
                        <form id = "editForm" action="<c:url value="/change-password"/>" method="POST">
                            <input type="hidden" name="username" value="${admin.account.username}"/>
                            <div class="form-group">
                                <label for="oldPassword"><span style="color: red;">*</span>Mật khẩu cũ</label>
                                <input type="password" class="form-control" name="oldPassword" id="oldPassword" required="required" >
                                <label for="newPassword"><span style="color: red;">*</span>Mật khẩu mới</label>
                                <input type="password" class="form-control" name="newPassword" id="newPassword" required="required" >
                                <label for="confirmNewPassword"><span style="color: red;">*</span>Xác nhận mật khẩu mới</label>
                                <input type="password" class="form-control" name="confirmNewPassword" id="confirmNewPassword" required="required" >
                            </div>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary" id ="confirm_pass_btn">Xác nhận</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer id="tg-footer" class="tg-footer tg-haslayout">
        <div class="tg-footerarea">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <ul class="tg-clientservices">
                            <li class="tg-devlivery">
                                <span class="tg-clientserviceicon"><i class="icon-rocket"></i></span>
                                <div class="tg-titlesubtitle">
                                    <h3>Vận chuyển </h3>
                                    <p>Toàn quốc nhanh chóng</p>
                                </div>
                            </li>
                            <li class="tg-discount">
                                <span class="tg-clientserviceicon"><i class="icon-tag"></i></span>
                                <div class="tg-titlesubtitle">
                                    <h3>Giá thành</h3>
                                    <p>Hợp lí hấp dẫn</p>
                                </div>
                            </li>
                            <li class="tg-quality">
                                <span class="tg-clientserviceicon"><i class="icon-leaf"></i></span>
                                <div class="tg-titlesubtitle">
                                    <h3>Chất lượng</h3>
                                    <p>Chất lượng hàng đầu</p>
                                </div>
                            </li>
                            <li class="tg-support">
                                <span class="tg-clientserviceicon"><i class="icon-heart"></i></span>
                                <div class="tg-titlesubtitle">
                                    <h3>Hỗ trợ 24/7</h3>
                                    <p>Phục vụ mọi lúc</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="tg-threecolumns">
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="tg-footercol">
                                <strong class="tg-logo"><a href="javascript:void(0);"><img src="assets/images/flogo.png" alt="image description"></a></strong>
                                <ul class="tg-contactinfo">
                                    <li>
                                        <i class="icon-apartment"></i>
                                        <address>Hà Đông, Hà Nội, Việt Nam</address>
                                    </li>
                                    <li>
                                        <i class="icon-phone-handset"></i>
                                        <span>
                                            <em>0812 567 889</em>
                                            <em>+84 1245 6767</em>
                                        </span>
                                    </li>
                                    <li>
                                        <i class="icon-clock"></i>
                                        <span>
                                            Phục vụ 7 ngày trong tuần từ 9:00 - 22:00
                                        </span>
                                    </li>
                                    <li>
                                        <i class="icon-envelope"></i>
                                        <span>
                                            <em><a href="mailto:support@domain.com">support@booklibrary.com</a></em>
                                            <em><a href="mailto:info@domain.com">info@booklibrary.com</a></em>
                                        </span>
                                    </li>
                                </ul>
                                <ul class="tg-socialicons">
                                    <li class="tg-facebook"><a href="javascript:void(0);"><i class="fa fa-facebook"></i></a></li>
                                    <li class="tg-twitter"><a href="javascript:void(0);"><i class="fa fa-twitter"></i></a></li>
                                    <li class="tg-linkedin"><a href="javascript:void(0);"><i class="fa fa-linkedin"></i></a></li>
                                    <li class="tg-googleplus"><a href="javascript:void(0);"><i class="fa fa-google-plus"></i></a></li>
                                    <li class="tg-rss"><a href="javascript:void(0);"><i class="fa fa-rss"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="tg-footercol tg-widget tg-widgetnavigation">
                                <div class="tg-widgettitle">
                                    <h3>Chúng tôi xin đảm bảo</h3>
                                </div>

                                <div class="tg-widgetcontent">

                                    <ul>
                                        <li><a href="javascript:void(0);">Luôn tôn trọng khách hàng</a></li>
                                        <li><a href="javascript:void(0);">Bảo mật thông tin cần thiết</a></li>
                                        <li><a href="javascript:void(0);">Sách chính hãng</a></li>
                                        <li><a href="javascript:void(0);">Tuân theo quy định mua bán</a></li>
                                    </ul> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tg-footerbar">
            <a id="tg-btnbacktotop" class="tg-btnbacktotop" href="javascript:void(0);"><i class="icon-chevron-up"></i></a>
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <span class="tg-paymenttype"><img src="../assets/images/paymenticon.png" alt="image description"></span>
                        <span class="tg-copyright">2023 All Rights Reserved By &copy; Book Library</span>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script src="../assets/js/vendor/jquery-library.js"></script>
    <script src="../assets/js/vendor/bootstrap.min.js"></script>
    <script src="https://maps.google.com/maps/api/js?key=AIzaSyCR-KEWAVCn52mSdeVeTqZjtqbmVJyfSus&amp;language=en"></script>
    <script src="../assets/js/owl.carousel.min.js"></script>
    <script src="../assets/js/jquery.vide.min.js"></script>
    <script src="../assets/js/countdown.js"></script>
    <script src="../assets/js/jquery-ui.js"></script>
    <script src="../assets/js/parallax.js"></script>
    <script src="../assets/js/countTo.js"></script>
    <script src="../assets/js/appear.js"></script>
    <script src="../assets/js/gmap3.js"></script>
    <script src="../assets/js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        const editBtn = document.querySelector('#edit-btn');
        const saveBtn = document.querySelector('#save-btn');
        // const addBtn = document.querySelector('#add-btn');
        // const uploadBtn = document.querySelector('#book-upload-btn');
        const nameUser = document.querySelector('#name');
        const emailUser = document.querySelector('#email');
        const addressUser = document.querySelector('#address');
        const usernameUser = document.querySelector('#username');
        const passwordUser = document.querySelector('#password');
        editBtn.addEventListener('click', function (event) {
            event.preventDefault();

            if (editBtn.innerHTML === 'Sửa') {
                nameUser.disabled = false;
                emailUser.disabled = false;
                addressUser.disabled = false;
                usernameUser.disabled = true;
                passwordUser.disabled = true;
                saveBtn.style.display = 'block';
                editBtn.style.display = 'none';
                // addBtn.style.display = 'none';
            }
        });
        saveBtn.style.display = 'none';
    </script>
    <div style="display: none" id="message" data-message="${message}"></div>
    <script>
        <c:if test="${not empty message}">
        $(document).ready(function () {
            var messageElement = document.getElementById('message');
            var message = messageElement.getAttribute('data-message');
            if (message === 'Thành công') {
                Swal.fire({
                    position: 'top',
                    icon: 'success',
                    title: 'Đổi mật khẩu thành công!',
                    showConfirmButton: false,
                    timer: 1500
                });
            } else {
                Swal.fire({
                    position: 'top',
                    icon: 'error',
                    title: message,
                    showConfirmButton: false,
                    timer: 1500
                });
            }
        });
        </c:if>
    </script>
</body>

</html>