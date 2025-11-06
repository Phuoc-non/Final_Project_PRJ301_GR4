<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Registration"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../WEB-INF/headerTotal.jsp" %>
<%
    Registration currentUser = (Registration) request.getAttribute("currentUser");
    if (currentUser == null) {
        currentUser = (Registration) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setAttribute("currentUser", currentUser);
    }
%>

<!-- Banner toàn màn hình -->
<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll"
     data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg"
     style="width:100%; background-size:cover; background-position:center;">
    <div class="container text-center">
        <div class="row">
            <div class="col-xs-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px; font-weight: bold;">Customer information</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/home">home</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Phần thông tin cá nhân -->
<main id="tg-main" class="tg-main tg-haslayout">
    <div class="tg-sectionspace tg-haslayout">
        <div class="container">
            <form action="${pageContext.request.contextPath}/profile" method="post" id="profileForm">
                <input type="hidden" name="id" value="${currentUser.id}"/>
                <div class="row">
                    <!-- Cột trái -->
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5 pull-left">
                        <h2>Personal information</h2>

                        <div class="form-group">
                            <label for="full_name"><strong>Full name</strong></label>
                            <input type="text" id="full_name" name="full_name" value="${currentUser.full_name}" class="form-control"
                                   style="width: 600px;" readonly/>
                        </div>

                        <div class="form-group">
                            <label for="email"><strong>Email</strong></label>
                            <input type="text" id="email" name="email" value="${currentUser.email}" class="form-control"
                                   style="width: 600px;" readonly/> <%-- đang tự động viết hoa kiếm coi nó nằm where(css)--%>
                        </div>


                        <div class="form-group">
                            <label for="phone"><strong>Phone</strong></label>
                            <input type="text" id="phone" name="phone" 
                                   value="${lastOrder.phone}" class="form-control" style="width: 600px;" readonly/>
                        </div>


                        <div class="form-group">
                            <label for="address"><strong>Address</strong></label>
                            <input type="text" id="address" name="address" value="${currentUser.address}" class="form-control"
                                   style="width: 600px;" readonly/>
                        </div>
                    </div>

                    <!-- Cột phải -->
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5 pull-right">
                        <h2>Account</h2>
                        <div class="form-group">
                            <label for="username"><strong>Username</strong></label>
                            <input type="text" id="username" name="username" value="${currentUser.username}" class="form-control"
                                   style="width: 400px;" readonly/>
                        </div>

                        <div class="form-group">
                            <label for="password"><strong>Password</strong></label>
                            <input type="password" id="password" name="password" value="${currentUser.password}" class="form-control"
                                   style="width: 400px;" readonly/>
                        </div>

                    </div>
                </div>


            </form>
        </div>
    </div>
</main>

<!-- Modal đổi mật khẩu -->
<div class="modal fade" id="modalChangePassword" tabindex="-1" role="dialog" aria-labelledby="modalChangePasswordLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" id="modalChangePasswordLabel">Verify password change</h4>
            </div>
            <div class="modal-body">
                <form id="changePasswordForm" action="${pageContext.request.contextPath}/change-password" method="POST">
                    <input type="hidden" name="username" value="${currentUser.username}"/>
                    <div class="form-group">
                        <label for="oldPassword">Old password</label>
                        <input type="password" class="form-control" name="oldPassword" id="oldPassword" required>
                        <label for="newPassword">New password</label>
                        <input type="password" class="form-control" name="newPassword" id="newPassword" required>
                        <label for="confirmNewPassword">Confirm new password</label>
                        <input type="password" class="form-control" name="confirmNewPassword" id="confirmNewPassword" required>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>

<script>
    const editBtn = document.querySelector('#edit-btn');
    const saveBtn = document.querySelector('#save-btn');
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
        if (message === 'successful') {
            Swal.fire({
                position: 'top',
                icon: 'success',
                title: 'Information updated successfully!',
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
