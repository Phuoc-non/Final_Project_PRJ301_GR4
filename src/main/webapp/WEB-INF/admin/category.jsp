
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="/WEB-INF/includes/headerTotal.jsp" %>

<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Category Management</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">Home page</a></li>
                        <li class="tg-active">Category</li>
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
                <div>
                    <div> 
                        <!-- <h2>Th�ng tin kh�ch h�ng</h2> -->
                        <div id="tg-content" class="tg-content">
                            <div class="tg-products">
                                <div class="tg-productgrid">
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-primary "  data-toggle="modal" data-target="#createModal" >
                                        Add new category
                                    </button> 

                                    <!-- Modal create -->
                                    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Are you sure you want to add this category?</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form method="POST" action="${pageContext.request.contextPath}/Category">
                                                        <label><span style="color: red;">*</span> Category Name</label>
                                                        <input  type="text" name="name"   required/>  <br/> <br/>

                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal" >Cancel</button>
                                                        <button type="submit" class="btn btn-primary" name="action" value="create" >Confirm </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                    <!-- Modal th�ng b�o l?i or th�nh c�ng -->
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
                                        //t? ?�ng sau 3 s
                                        setTimeout(() => {
                                            $('#resultModal').modal('hide');
                                        }, 3000);


                                    </script>


                                    <div class="row">
                                        <table class="table table-bordered">
                                            <tr>
                                                <th>No.</th>
                                                <th>Category Name</th>
                                                <th>Number of Books</th>
                                                <th>Created Date</th>
                                                <th>Updated Date</th>
                                                <th>Actions</th>
                                            </tr>
                                            <c:forEach var="cate" varStatus="loop" items="${category}"> 


                                                <tr class="active-row">
                                                    <td>${loop.index+1} </td>
                                                    <td > ${cate.name}</td>
                                                    <td > ${cate.quantity}</td>
                                                    <td><fmt:formatDate value="${cate.dayCreate}" pattern="dd-MM-yyyy"/></td>
                                                    <td><fmt:formatDate value="${cate.dayUpdate}" pattern="dd-MM-yyyy"/></td>
                                                    <td>
                                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#editModal" data-id="${loop.index+1}">Edit</button>

                                                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal" data-id="${loop.index+1}" data-quantity="${cate.quantity}">Delete</button>
                                                    </td>
                                                </tr>


                                            </c:forEach>
                                            <!-- Modal edit -->
                                            <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Are you sure you want to edit this category?</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form method="POST" action="${pageContext.request.contextPath}/Category">
                                                                <label><span style="color: red;">*</span> Category Name</label>
                                                                <input  type="text" name="name"   required/>  <br/> <br/>
                                                                <input    type="hidden" name="id" id="cateIdInput"/>
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                                <button type="submit" class="btn btn-primary" name="action" value="edit" >Confirm </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  
                                            <script>
                                                $('#editModal').on('show.bs.modal', function (event) {
                                                    var button = $(event.relatedTarget); // N�t Edit v?a click
                                                    var cateId = button.data('id');      // L?y id t? data-id



                                                    // G�n id v�o input ?n trong modal (?? g?i form)
                                                    $(this).find('#cateIdInput').val(cateId);


                                                });
                                            </script>

                                            <!-- Modal delete -->
                                            <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="deleteTitle"></h5>

                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body" >
                                                            <form  id="deleteButtons" method="POST" action="${pageContext.request.contextPath}/Category">
                                                                <input type="hidden" name="id" id="cateId">


                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <script>
                                                $('#deleteModal').on('show.bs.modal', function (event) {
                                                    var button = $(event.relatedTarget);
                                                    var cateId = button.data('id');
                                                    var quantity = Number(button.data('quantity'));

                                                    var modal = $(this);
                                                    modal.find('#cateId').val(cateId);

                                                    if (quantity !== 0) {
                                                        modal.find('#deleteTitle').text('Cannot delete a category that has books in it!');
                                                        modal.find('#deleteButtons').html(`
            <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
        `);
                                                    } else {
                                                        modal.find('#deleteTitle').text('Are you sure you want to delete this category?');
                                                        modal.find('#deleteButtons').html(`
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary" name="action" value="delete">Confirm</button>
        `);
                                                    }
                                                });

                                            </script>
                                        </table>
                                    </div>



                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
        <!-- ? Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <!-- N�t Previous -->
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link"
                       href="<c:url value='/category'><c:param name='page' value='${currentPage - 1}'/></c:url>"
                           aria-label="Previous">&laquo;</a>
                    </li>

                    <!-- C�c s? trang -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link"
                           href="<c:url value='/category'><c:param name='page' value='${i}'/></c:url>">${i}</a>
                        </li>
                </c:forEach>

                <!-- N�t Next -->
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link"
                       href="<c:url value='/category'><c:param name='page' value='${currentPage + 1}'/></c:url>"
                           aria-label="Next">&raquo;</a>
                    </li>
                </ul>
            </nav>
        </div>
    </main>



<%@include file="/WEB-INF/includes/footer.jsp" %>