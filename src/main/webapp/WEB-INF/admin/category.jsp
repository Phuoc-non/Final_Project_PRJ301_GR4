<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/header.jsp" %>

<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Quản lý Danh mục</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">Trang chủ</a></li>
                        <li class="tg-active">Danh mục</li>
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
                        <!-- <h2>Thông tin khách hàng</h2> -->
                        <div id="tg-content" class="tg-content">
                            <div class="tg-products">
                                <div class="tg-productgrid">
                                    <!-- Button trigger modal -->
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                                        Launch demo modal
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Are you sure you want to add this category?</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    ...
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                    <a role="button" class="btn btn-primary" href="">confirm </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>



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
                                                    <td > ${cate.dayCreate}</td>
                                                    <td >${cate.dayUpdate}</td> 
                                                    <td>
                                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#updateModal">Sửa</button>
                                                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">Xóa</button>
                                                    </td>
                                                </tr>

                                            </c:forEach>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
</main>

<%@include file="/footer.jsp" %>