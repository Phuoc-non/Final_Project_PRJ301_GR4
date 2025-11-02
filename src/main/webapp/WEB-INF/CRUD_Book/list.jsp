<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/headerTotal.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!--************************************
                Main Start
*************************************-->
<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="../images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1 style="margin-bottom: 20px;">Book Management</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">Home page</a></li>
                        <li class="tg-active">Book</li>
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
                        <div id="tg-content" class="tg-content">
                            <div class="tg-products">
                                <div class="tg-productgrid">
                                    <div class="tg-refinesearch d-flex justify-content-between align-items-center mb-3">
                                        <a href="http://localhost:8080/Lib/bm?view=create">
                                            <button type="submit" class="btn btn-primary"> Add Books  </button>
                                        </a>
                                        <form class="tg-formtheme tg-formsortshoitems" action="bm" method="get">
                                            <input type="hidden" name="view" value="list"/>
                                            <fieldset>
                                                <div class="form-group d-flex align-items-center">
                                                    <select name="sortBy" id="sortBy" onchange="this.form.submit()">
                                                        <option value="">---Select sort---</option>
                                                        <option value="title" ${sortBy == 'title' ? 'selected' : ''}>Book Name</option>
                                                        <option value="price" ${sortBy == 'price' ? 'selected' : ''}>Price</option>
                                                        <option value="number_sold" ${sortBy == 'number_sold' ? 'selected' : ''}>Quantity Sold</option>
                                                    </select>
                                                </div>
                                            </fieldset>
                                        </form>

                                    </div>

                                    <div class="row">
                                        <table class="table table-bordered table-striped">
                                            <thead class="table-success">
                                                <% List<Product> list = (List<Product>) request.getAttribute("list");
                                                    int count = 1;
                                                %>
                                                <tr>
                                                    <th>No.</th>
                                                    <th>Book Title</th>
                                                    <th>Image</th>
                                                    <th>Category</th>
                                                    <th>Author</th>
                                                    <th>Price</th>
                                                    <th>Sold</th>
                                                    <th>Created Date</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Product pr : list) {%>

                                                <tr>
                                                    <td><%= count%> </td>
                                                    <td><%= pr.getName_product()%></td>
                                                    <td>
                                                        <img src="<%= pr.getImg()%>" alt="Product Image" width="150" height="200">
                                                    </td>
                                                    <td><%= pr.getCategory_name()%></td>
                                                    <td><%= pr.getAuthor_name()%></td>
                                                    <td><%=pr.getPrice_product()%></td>
                                                    <td><%=pr.getQuantity_orderDetail()%></td>
                                                    <td><fmt:formatDate value="<%= pr.getCreated_product()%>" pattern="dd-MM-yyyy"/></td>
                                                    <td>
                                                        <a href="<%= request.getContextPath()%>/bm?view=detail&sku=<%= pr.getSku_product()%>" class="btn btn-primary">Detail</a>
                                                        <form action="bm" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="sku" value="<%=pr.getSku_product()%>">
                                                            <button type="submit" class="btn btn-danger"
                                                                    onclick="return confirm('Are you sure you want to delete this book?');">
                                                                Delete
                                                            </button>
                                                        </form>
                                                    </td>

                                                </tr>
                                                <% count++;
                                                    }%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Phân trang -->
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

                        <p style="text-align:center; color:red;">
                            totalPages = ${totalPages}, currentPage = ${currentPage}
                        </p>


                        <!-- 🌿 Pagination -->
                        <!-- 🌿 Pagination -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Nút Previous -->
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="bm?page=${currentPage - 1}" aria-label="Previous">&laquo;</a>
                                </li>

                                <!-- Các số trang -->
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="bm?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Nút Next -->
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="bm?page=${currentPage + 1}" aria-label="Next">&raquo;</a>
                                </li>
                            </ul>
                        </nav>


                    </div>
                </div>
            </div>
        </div>
    </div>

</main>
<!--************************************
                Main End
*************************************-->

<%@include file="../includes/footer.jsp" %>
