<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../includes/headerTotal.jsp" %>

<div class="container mt-4">
    <div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
         data-z-index="-100"
         data-appear-top-offset="600"
         data-parallax="scroll"
         data-image-src="../images/parallax/bgparallax-07.jpg">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="tg-innerbannercontent">
                        <h1 style="margin-bottom: 20px;">Book Detail</h1>
                        <ol class="tg-breadcrumb">
                            <li><a href="${pageContext.request.contextPath}/bm">Home Page</a></li>
                            <li class="tg-active">Book Detail</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3">${error}</div>
    </c:if>

    <% Product p = (Product) request.getAttribute("product");%>


    <div class="row mt-4">
        <!-- LEFT FORM -->
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Title</label>
                    <input type="text" class="form-control" readonly value="<%= p.getName_product()%>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Author</label>
                    <input type="text" class="form-control" readonly value="<%= p.getAuthor_name()%>">
                </div>
            </div> <br>

            <div class="mb-3">
                <label class="form-label fw-semibold"><span style="color:red">*</span>Description</label>
                <textarea class="form-control" rows="4" readonly><%= p.getDescription_product()%></textarea>
            </div> <br>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Release Date</label>
                    <input type="text" class="form-control" readonly value="<%= p.getCreated_product()%>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Pages</label>
                    <input type="number" class="form-control" readonly value="<%= p.getPages()%>">
                </div>
            </div> <br>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Catalog</label>
                    <input type="text" class="form-control" readonly value="<%= p.getCategory_name()%>">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Book Code</label>
                    <input type="text" class="form-control" readonly value="<%= p.getSku_product()%>">
                </div>
            </div> <br>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Price</label>
                    <input type="text" class="form-control" readonly value="<%= p.getPrice_product()%>">
                </div>
            </div> 
        </div>

        <!-- RIGHT IMAGE PANEL -->
        <div class="col-md-4 text-center">
            <div class="border d-flex align-items-center justify-content-center rounded-3"
                 style="width: 200px; height: 300px; margin: 0 auto; background-color: #f8f9fa;">
                <%
                    String imgPath = p.getImg();
                    if (imgPath != null && !imgPath.trim().isEmpty()) {
                        // Nếu link bắt đầu bằng "http" => giữ nguyên, ngược lại thêm context path
                        if (imgPath.startsWith("http")) {
                %>
                <img src="<%= imgPath%>" alt="Book Image"
                     style="max-width:100%; max-height:100%; object-fit:contain;">
                <%
                } else {
                %>
                <img src="<%= request.getContextPath()%>/images/<%= imgPath%>" alt="Book Image"
                     style="max-width:100%; max-height:100%; object-fit:contain;">
                <%
                    }
                } else {
                %>
                <span style="color:#888;">No image available</span>
                <%
                    }
                %>
            </div>
        </div>
    </div> <br>

    <div class="text-end mt-4">
        <a href="<%= request.getContextPath()%>/bm?view=update&sku=<%= p.getSku_product()%>" class="btn btn-danger">Update</a>
        <a href="<%= request.getContextPath()%>/bm" class="btn btn-primary me-2">Back</a>
    </div>


    <br><br>
</div>

<%@include file="../includes/footer.jsp"%>
