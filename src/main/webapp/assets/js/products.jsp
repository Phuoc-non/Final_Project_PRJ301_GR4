<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../includes/header.jsp" %>

<!--************************************
    Header End
*************************************-->

<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner"
     data-z-index="-100" data-appear-top-offset="600"
     data-parallax="scroll"
     data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg">
    <div class="container">
        <div class="tg-innerbannercontent text-center">
            <h1>All Products</h1>
            <ol class="tg-breadcrumb">
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li class="tg-active">Products</li>
            </ol>
        </div>
    </div>
</div>

<!--************************************
    Main Start
*************************************-->
<main id="tg-main" class="tg-main tg-haslayout">
    <div class="tg-sectionspace tg-haslayout">
        <div class="container">
            <div class="row">
                <div id="tg-twocolumns" class="tg-twocolumns">
                    <!-- RIGHT CONTENT -->
                    <div class="col-xs-12 col-sm-8 col-md-8 col-lg-9 pull-right">
                        <div id="tg-content" class="tg-content">
                            <div class="tg-products">
                                <div class="tg-productgrid">
                                    <div class="tg-refinesearch d-flex justify-content-between align-items-center">
                                        <span>Showing ${fn:length(products)} products</span>
                                        <a href="${pageContext.request.contextPath}/bm?view=create" class="btn btn-success btn-sm">
                                            <i class="fa fa-plus"></i> Add New Book
                                        </a>
                                    </div>

                                    <!-- ============ VÒNG LẶP HIỂN THỊ SẢN PHẨM ============ -->
                                    <c:forEach var="p" items="${products}">
                                        <div class="col-xs-6 col-sm-6 col-md-4 col-lg-3 mb-4">
                                            <div class="tg-postbook shadow-sm">
                                                <figure class="tg-featureimg">
                                                    <div class="tg-bookimg">
                                                        <div class="tg-frontcover">
                                                            <img src="${pageContext.request.contextPath}/assets/images/books/${p.img}" alt="${p.name}">
                                                        </div>
                                                    </div>
                                                </figure>
                                                <div class="tg-postbookcontent">
                                                    <div class="tg-booktitle">
                                                        <h4><a href="${pageContext.request.contextPath}/bm?view=detail&sku=${p.sku}">
                                                                ${p.name}
                                                            </a></h4>
                                                    </div>
                                                    <span class="tg-bookwriter">
                                                        <i class="fa fa-barcode"></i> SKU: ${p.sku}
                                                    </span>
                                                    <span class="tg-bookprice">
                                                        <ins>$${p.price}</ins>
                                                    </span>

                                                    <!-- Nút hành động -->
                                                    <div class="d-flex justify-content-between mt-2">
                                                        <a href="${pageContext.request.contextPath}/bm?view=detail&sku=${p.sku}" class="btn btn-info btn-sm">
                                                            <i class="fa fa-eye"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/bm?view=edit&sku=${p.sku}" class="btn btn-warning btn-sm">
                                                            <i class="fa fa-edit"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/bm?view=delete&sku=${p.sku}" class="btn btn-danger btn-sm">
                                                            <i class="fa fa-trash"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <!-- ============ HẾT VÒNG LẶP ============ -->

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- LEFT SIDEBAR -->
                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3 pull-left">
                        <aside id="tg-sidebar" class="tg-sidebar">
                            <div class="tg-widget tg-widgetsearch">
                                <form action="${pageContext.request.contextPath}/bm" method="get" class="tg-formtheme tg-formsearch">
                                    <input type="hidden" name="view" value="list">
                                    <div class="form-group">
                                        <button type="submit"><i class="icon-magnifier"></i></button>
                                        <input type="search" name="keyword" class="form-control"
                                               placeholder="Search by name...">
                                    </div>
                                </form>
                            </div>
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="../includes/footer.jsp" %>
