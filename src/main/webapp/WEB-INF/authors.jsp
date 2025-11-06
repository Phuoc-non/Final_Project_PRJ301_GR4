<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../WEB-INF/includes/headerTotal.jsp"/>


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
                <!-- THÔNG BÁO THÀNH CÔNG / LỖI - TƯƠNG THÍCH BOOTSTRAP 3 -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible" role="alert" style="margin-top: 20px;">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <strong></strong> ${sessionScope.successMessage}
                    </div>
                    <% session.removeAttribute("successMessage"); %>
                </c:if>

                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible" role="alert" style="margin-top: 20px;">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <strong></strong> ${sessionScope.errorMessage}
                    </div>
                    <% session.removeAttribute("errorMessage");%>
                </c:if>



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
                                <td><fmt:formatDate value="${author.created_at}" pattern="dd/MM/yyyy" /></td>
                                <td><fmt:formatDate value="${author.updated_at}" pattern="dd/MM/yyyy" /></td>

                                <td class="text-center">
                                    <!-- NÚT SỬA: BÚT + VỞ -->
                                    <button type="button" class="btn btn-warning btn-sm" 
                                            data-toggle="modal" data-target="#myModal_edit${author.id}"
                                            title="Sửa tác giả">
                                        <i class="fa fa-pencil-square-o"></i>
                                    </button>

                                    <!-- NÚT XÓA: THÙNG RÁC -->
                                    <button type="button" class="btn btn-danger btn-sm" 
                                            data-toggle="modal" data-target="#myModal_delete${author.id}"
                                            title="Xóa tác giả">
                                        <i class="fa fa-trash"></i>
                                    </button>
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

                                        <!-- THÊM DÒNG NÀY -->
                                        <input type="hidden" name="bookcount" value="${author.bookcount}">

                                        <div class="modal-header">
                                            <h4 class="modal-title">Bạn chắc chắn muốn xóa tác giả này?</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p><strong>${author.name}</strong> sẽ bị xóa vĩnh viễn.</p>
                                            <c:if test="${author.bookcount > 0}">
                                                <p class="text-danger">
                                                    ⚠️ Tác giả này đang có <strong>${author.bookcount}</strong> cuốn sách!<br>
                                                    Không thể xóa nếu còn sách.
                                                </p>
                                            </c:if>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-danger" 
                                                    ${author.bookcount > 0 ? 'disabled' : ''}>
                                                Xác nhận xóa
                                            </button>
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
                <form action="${pageContext.request.contextPath}/authors" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="modal-header">
                        <h4 class="modal-title">Thêm tác giả mới</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Tên tác giả</label>
                            <input name="name" type="text" class="form-control" 
                                   pattern="[a-zA-Z\-\s]+" 
                                   title="Chỉ được nhập chữ cái!"
                                   required>
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

    <jsp:include page="../WEB-INF/includes/footer.jsp"/>
</body>
</html>
