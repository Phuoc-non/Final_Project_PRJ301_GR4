<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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



    <div class="row mt-4">
        <!-- LEFT FORM -->
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Title</label>
                    <input type="text" class="form-control" readonly value="${product.name_product}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Author</label>
                    <input type="text" class="form-control" readonly value="${product.author_name}">
                </div>
            </div> <br>

            <div class="mb-3">
                <label class="form-label fw-semibold"><span style="color:red">*</span>Description</label>
                <textarea class="form-control" rows="4" readonly>${product.description_product}</textarea>
            </div> <br>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Release Date</label>
                    <input type="text" class="form-control" readonly value="${product.created_product}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Pages</label>
                    <input type="number" class="form-control" readonly value="${product.pages}">
                </div>
            </div> <br>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Catalog</label>
                    <input type="text" class="form-control" readonly value="${product.category_name}">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Book Code</label>
                    <input type="text" class="form-control" readonly value="${product.sku_product}">
                </div>
            </div> <br>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color:red">*</span>Price</label>
                    <input type="text" class="form-control" readonly value="${product.price_product}">
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-semibold"><span style="color: red">*</span>Quantity</label>
                    <input type="number" class="form-control" name="quantity" readonly value="${product.quantity}">
                </div>
            </div> 
        </div>

        <!-- RIGHT IMAGE PANEL -->
        <div class="col-md-4 text-center">


            <div class="border d-flex align-items-center justify-content-center rounded-3"
                 style="width: 200px; height: 300px; margin: 0 auto; background-color: #f8f9fa;">

                <c:choose>
                    <c:when test="${not empty product.img}">
                        <c:choose>

                            <c:when test="${fn:startsWith(product.img, 'http')}">
                                <img src="${product.img}" alt="Book Image"
                                     style="max-width:100%; max-height:100%; object-fit:contain;">
                            </c:when>

                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/${product.img}" alt="Book Image"
                                     style="max-width:100%; max-height:100%; object-fit:contain;">
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <span style="color:#888;">No image available</span>
                    </c:otherwise>
                </c:choose>
            </div>




        </div>
    </div> <br>

    <div class="text-end mt-4">
        <a href="${pageContext.request.contextPath}/bm?view=update&sku=${product.sku_product}" class="btn btn-danger">Update</a>
        <a href="${pageContext.request.contextPath}/bm" class="btn btn-primary me-2">Back</a>
    </div>


    <br><br>
</div>

<%@include file="../includes/footer.jsp"%>
