<%-- 
Document   : productdetail
Created on : Oct 15, 2025, 2:33:11 PM
Author     : Asus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/headerTotal.jsp" %>
<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg">


    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1>All Products</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="javascript:void(0);">home</a></li>
                        <li><a href="javascript:void(0);">Products</a></li>
                        <li class="tg-active">Product Title Here</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>
<main id="tg-main" class="tg-main tg-haslayout">
    <div class="tg-sectionspace tg-haslayout">
        <div class="container">
            <div class="row">
                <div id="tg-twocolumns" class="tg-twocolumns">
                    <div>
                        <!-- <h2> <span>T?t c? sách  </span> </h2> -->
                        <div>
                            <th:block th:if="">
                                <form method="post" th:action="@{/purchase}">
                                    <table class="styled-table">
                                        <thead>

                                            <tr>
                                                <th>No.</th>
                                                <th>Book name</th>
                                                <th>Image</th>
                                                <th>Selling price</th>
                                                <th>Quantity</th>
                                                <th>Total</th> 
                                                <th>Action</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody >
                                            `<c:set var="count" value="0" scope="page"/> 
                                            <c:forEach var="item" items="${listCartItem}">
                                                <c:set var="count" value="${count+1}" scope="page"></c:set>
                                                    <tr class="active-row">

                                                        <td>${count}</td>
                                                    <td>${item.getProduct().bookName}</td>

                                                    <td><img src="${item.getProduct().img}" alt="image description" style="height: 100px;"></td>
                                                    <td style="font-size : 15px">${item.getProduct().price} $</td>
                                                    <td class="tg-quantityholder">
                                                        <em class="minus">-</em>
                                                        <input type="text" value="${item.quantity}" class="quan" data-max="${item.getProduct().quantity}" data-sku="${item.sku}" data-price="${item.getProduct().price}" style="width: 80px; margin-top: 5px;">

                                                        <em class="plus">+</em>

                                                    </td>
                                                    <td class="total">${item.quantity * item.getProduct().price} $</td>
                                                    <td>
                                                        <a href="">
                                                            <button type="button" class="btn btn-danger delete" data-sku="${item.sku}" style="width: 80px;">
                                                                <i class="fa-solid fa-trash"></i>
                                                            </button>
                                                        </a> 
                                                    </td>

                                                </tr>  
                                            </c:forEach>

                                            <c:if test="${not empty listCartItem}">
                                                <tr><td colspan="7">
                                                        <button  class="btn btn-primary"  style="background: green; width: 200px; margin-bottom: 5px; margin-top: 5px;  " 
                                                                 type="submit">Đặt hàng</button>
                                                    </td></tr>
                                                </c:if>           


                                        </tbody>
                                    </table>
                                </form>
                            </th:block>
                            <c:if test="${ empty listCartItem}">
                                <th:block>
                                    <h5 style="color: red; margin-top: 5px;">Hiện tại giỏ sách trống</h5>
                                </th:block>
                            </c:if>               

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="../includes/footer.jsp" %>