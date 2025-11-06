<%-- 
    Document   : promotion
    Created on : Oct 19, 2025, 12:53:25?PM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/includes/headerTotal.jsp" %>

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


<!-- Tiêu đề trang -->
<div class="d-flex justify-content-between align-items-center mb-5">

    <button class="btn btn-primary " data-toggle="modal" data-target="#addPromoModal">
        Thêm khuyến mãi
    </button>
    <!-- Modal thêm khuyến mãi -->
    <div class="modal fade" id="addPromoModal" tabindex="-1" role="dialog" aria-labelledby="addPromoModalLabel" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <form method="POST" action="${pageContext.request.contextPath}/promotion">
                    <div class="modal-header  bg-warning text-dark p-3">
                        <h5 class="modal-title" >Thêm khuyến mãi mới</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span>&times;</span>
                        </button>
                    </div>
                    <div class="modal-body bg-info text-white p-3">


                        <div class="form-group col-md-6">
                            <label><span style="color: red;">*</span>Mã khuyến mãi</label>

                            <input type="text" name="code" pattern="[A-Z0-9]{10}" required
                                   title="Enter exactly 6 characters: uppercase letters and digits only">

                        </div>

                        <div class="form-group col-md-4">
                            <label><span style="color: red;">*</span>Ngày bắt đầu</label>
                            <input type="date"  name="sday"> 
                        </div>
                        <div class="form-group col-md-4">
                            <label><span style="color: red;">*</span>Ngày kết thúc</label>
                            <input type="date"  name="eday">
                        </div>

                       

                        <div class="form-group col-md-4">
                            <label><span style="color: red;">*</span>Giá trị giảm %</label>

                            <input type="number"  placeholder="Nhập % " name="discount" min="1" max="100" title="enter only from 1 to 100" required> 

                        </div>

                        <div class="form-group col-md-4">
                            <label><span style="color: red;">*</span>giá trị đơn hàng giảm giá</label>

                            <input type="number" min="1" required placeholder="Nhập số tiền Đơn hàng cần để giảm..." title="only enter greater than or equal to 1" name="minValue">
                        </div>

                        <div class="form-group col-md-4">
                            <label>Mô tả</label>
                            <textarea class="form-control" id="message-text" name="description"></textarea>
                        </div>


                        <button type="button" class="btn btn-secondary" data-dismiss="modal" >Cancel</button>
                        <button type="submit" class="btn btn-primary" name="action" value="create" >Confirm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>


<!-- Bảng danh sách khuyến mãi -->
<div class="card shadow-sm">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table  table-hover mb-0">
                <thead class=" bg-info thead-light">
                    <tr>

                        <th>Mã KM</th>
                        <th>Giảm (%)</th>
                        <th>giá trị đơn hàng giảm giá</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Trạng thái</th>
                        <th>description</th>
                        <th >Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pro" items="${list}">
                        <tr>      
                            <td>${pro.code}</td>
                            <td>${pro.discount}</td>

                            <td>${pro.minOrderValue}</td>
                            <td><fmt:formatDate value="${pro.startDay}" pattern="dd-MM-yyyy"/></td>
                            <td><fmt:formatDate value="${pro.endDay}" pattern="dd-MM-yyyy"/></td>

                        
                            <c:choose>
                                <c:when test="${pro.status == 1}">
                                    <td class="bg-success text-white">Đang diễn ra</td>
                                </c:when>
                                <c:when test="${pro.status == 2}">
                                    <td class="" style=" background-color:#73aef6; color: white;" >Chưa diễn ra</td>
                                </c:when>
                                <c:otherwise>
                                    <td class="" style=" background-color:#fa86a1; color: white;"> Đã diễn ra</td>
                                </c:otherwise>
                            </c:choose>
                            <td>${pro.description}</td>
                            <td class="text-center">

                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#editModal" data-code="${pro.code}" data-sday="${pro.startDay}" 
                                        data-eday="${pro.endDay}" data-discount="${pro.discount}" data-description="${pro.description}" data-minvalue="${pro.minOrderValue}"
                                        data-id="${pro.id}"    >Edit</button>

                                <button type="button"   class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="${pro.id}">Delete</button>
                            </td>

                        </tr>
                    </c:forEach>
                </tbody>

                <!-- Modal edit -->
                <div  class="modal fade "  id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-content" role="document" >
                        <div class="modal-content">
                            <div  class="  modal-header" style="background-color: #f6462b;" >
                                <h5 class="modal-title" style="color: white"id="exampleModalLabel">Are you sure you want to edit this promotion?</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body  bg-info text-white p-3">
                                <form method="POST" action="${pageContext.request.contextPath}/promotion">
                                    <input type="hidden" id="idInput" name="id"/>
                                    <div class="form-group col-md-6">
                                        <label> Mã khuyến mãi</label>
                                        <input  type="text"   name="code" id="codeInput" required/>  
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Ngày bắt đầu</label>
                                        <input  readonly type="date"  id="sdayInput" > 
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Ngày kết thúc</label>
                                        <input  readonly type="date"  id="edayInput">
                                    </div>
                                  

                                    <div class="form-group col-md-6">
                                        <label>Giá trị giảm %</label>
                                        <input type="number" min="1" max="100" required id="discountInput" name="discount">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>giá trị đơn hàng giảm giá</label>
                                        <input type="number" min="1" required id="minvalueInput" name="minValue">
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label>Mô tả</label>
                                        <textarea class="form-control" id="descriptionInput" name="description"></textarea>
                                    </div>


                                    <button type="button" class="btn btn-secondary " data-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary " name="action" value="edit" >Save </button>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>  
                <script>
                    $('#editModal').on('show.bs.modal', function (event) {
                        var button = $(event.relatedTarget); // Nút Edit v?a click
                        var code = button.data('code'); // L?y id t? data-id
                        var sday = button.data('sday');
                        var eday = button.data('eday');
                        var description = button.data('description');
                        var minvalue = button.data('minvalue');
                        var discount = button.data('discount');
                        var id = button.data('id');
                      
                        // Gán id vào input ?n trong modal (?? g?i form)
                        $(this).find('#codeInput').val(code);
                        $(this).find('#sdayInput').val(sday);
                        $(this).find('#edayInput').val(eday);
                        $(this).find('#descriptionInput').val(description);
                        $(this).find('#minvalueInput').val(minvalue);
                        $(this).find('#discountInput').val(discount);
                        $(this).find('#idInput').val(id);
                       
                    });
                </script>


                <!-- Modal delete -->
                <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color:#f03333;">
                                <h5 class="modal-title" style="color: white;" > Are you sure you want to delete this promotion? </h5>

                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" >
                                <form   method="POST" action="${pageContext.request.contextPath}/promotion">
                                    <input type="hidden" name="id" id="idInput"/>

                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary" name="action" value="delete">Confirm</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    $('#deleteModal').on('show.bs.modal', function (event) {
                        var button = $(event.relatedTarget);
                        var id = button.data('id');
                        $(this).find('#idInput').val(id);
                    });
                </script>



            </table>
        
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
                           href="<c:url value='/Promotion'><c:param name='page' value='${currentPage - 1}'/></c:url>"
                               aria-label="Previous">&laquo;</a>
                        </li>

                        <!-- Các số trang -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="<c:url value='/Promotion'><c:param name='page' value='${i}'/></c:url>">${i}</a>
                            </li>
                    </c:forEach>

                    <!-- Nút Next -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="<c:url value='/Promotion'><c:param name='page' value='${currentPage + 1}'/></c:url>"
                               aria-label="Next">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        
       
        </div>
    </div>


    <!-- Modal thông báo l?i or thành công -->
<c:if test="${not empty message}">
    <div class="modal fade" id="resultModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header ${messageType == 'success' ? 'bg-success' : 'bg-danger'} text-white">
                    <h5 class="modal-title">
                        ${messageType == 'success' ? 'Success' : 'Error'}
                    </h5>

                </div>
                <div class="modal-body">
                    <p>${message}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

</c:if>

<script>
    // T? ??ng m? modal sau khi trang t?i l?i
    $(document).ready(function () {
        $('#resultModal').modal('show');
    });
    //t? ?óng sau 3 s
    setTimeout(() => {
        $('#resultModal').modal('hide');
    }, 3000);


</script>







<%@include file="/WEB-INF/includes/footer.jsp" %>