<%-- 
    Document   : productdetail
    Created on : Oct 15, 2025, 2:33:11 PM
    Author     : Asus
--%>
<%@page import="model.UserReview"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/headerTotal.jsp" %>

<!--************************************
                Inner Banner Start
*************************************-->
<div class="tg-innerbanner tg-haslayout tg-parallax tg-bginnerbanner" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-07.jpg">


    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-innerbannercontent">
                    <h1>All Products</h1>
                    <ol class="tg-breadcrumb">
                        <li><a href="book">home</a></li>
                        <li><a href="ab?cate=all">Products</a></li>
                        <li class="tg-active">Product Title Here</li>
                    </ol>
                </div>  
            </div>
        </div>
    </div>
</div>
<!--************************************
                Inner Banner End
*************************************-->
<!--************************************
                Main Start
*************************************-->
<main id="tg-main" class="tg-main tg-haslayout">
    <!--************************************
                    News Grid Start
    *************************************-->
    <div class="tg-sectionspace tg-haslayout">
        <div class="container">
            <div class="row">
                <div id="tg-twocolumns" class="tg-twocolumns">
                    <div class="col-xs-12 col-sm-8 col-md-8 col-lg-12 pull-left">
                        <div id="tg-content" class="tg-content">

                            <div class="tg-productdetail">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">

                                        <div class="tg-postbook">

                                            <figure class="tg-featureimg"><img src="${productdetail.getProduct().img}" alt="image description"></figure>

                                            <div class="tg-postbookcontent">
                                                <span class="tg-bookprice">
                                                    <ins>${productdetail.getProduct().price}</ins>
                                                    
                                                </span>
                                                <span class="tg-bookwriter">You save $4.02</span>
                                                <ul class="tg-delevrystock">
                                                    <li><i class="icon-rocket"></i><span>Free delivery worldwide</span></li>
                                                    <li><i class="icon-checkmark-circle"></i><span>Dispatch from the USA in 2 working days </span></li>

                                                </ul>
                                                <div class="tg-quantityholder">

                                                    <p>Quantity</p>
                                                    <em class="minus">-</em>
                                                    <input type="text" class="result" value="1" id="quantity1" name="quantity" data-max="${productdetail.getProduct().quantity}">
                                                    <em class="plus">+</em> 
                                                    <p id="quantitymax">${productdetail.getProduct().quantity} products available</p>   
                                                </div>

                                                <a class="tg-btn tg-active tg-btn-lg add" style="cursor: pointer"  id="addToBasket" data-sku="${productdetail.getProduct().sku}">Add To Basket</a>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">

                                        <ul class="tg-bookscategories">
                                            <li>${productdetail.getCategory().name}</li>
                                        </ul>
                                        <!--                                        <div class="tg-themetagbox"><span class="tg-themetag">sale</span></div>-->
                                        <div class="tg-booktitle">
                                            <h2>${productdetail.bookName}</h2>
                                        </div>
                                        <span class="tg-bookwriter">By: ${productdetail.getAuthor().name}</span>
                                        <!--                                            <span class="tg-stars"><span></span></span>-->
                                        <%--    <c:set  var="avrRating" value="0"></c:set>
                                        <c:set  var="count" value="0"></c:set>
                                        <c:forEach var="rating" items="${reviewer}">
                                            <c:set var="sum" value="${sum + rating}" />
                                            <c:set var="count" value="${count + 1}" />
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${count > 0}">
                                                <c:set var="avgRating" value="${sum / count}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="avgRating" value="0" />
                                            </c:otherwise>
                                        </c:choose>
                                        <!-- Hiển thị sao -->
                                        <c:set var="fullStars" value="${fn:floor(avgRating)}" />
                                        <c:set var="halfStar" value="${avgRating - fullStars >= 0.5}" />

                                        <div>
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= fullStars}">
                                                        <i class="fas fa-star text-warning"></i>
                                                    </c:when>
                                                    <c:when test="${halfStar and i == fullStars + 1}">
                                                        <i class="fas fa-star-half-alt text-warning"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="far fa-star text-warning"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <span class="ml-2">(${avgRating}/5)</span>
                                        </div>
                                        --%>
                                        <%
                                            List<UserReview> ratings = (List<UserReview>) request.getAttribute("reviewer");
                                            double avgRating = 0;
                                            if (ratings != null && !ratings.isEmpty()) {
                                                int sum = 0;
                                                for (UserReview r : ratings) {
                                                    sum += r.getRating();
                                                }
                                                avgRating = (double) sum / ratings.size();
                                            }
                                        %>

                                        <div>
                                            <%
                                                int fullStars = (int) Math.floor(avgRating);//làm tròn xuống
                                                boolean halfStar = (avgRating - fullStars) >= 0.5;
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= fullStars) {//in ra số sao đầy
                                            %>
                                            <i class="fas fa-star text-warning" style="color:#FFD700"></i>
                                            <%
                                            } else if (halfStar && i == fullStars + 1) {// in ra số sao nửa
                                            %>
                                            <i class="fas fa-star-half-alt text-warning" style="color:#FFD700"></i>
                                            <%
                                            } else {// in ra số sao rỗng
                                            %>
                                            <i class="far fa-star text-warning"></i>
                                            <%
                                                    }
                                                }
                                            %>
                                            <span class="ml-2">(<%= String.format("%.1f", avgRating)%>/5)</span>
                                        </div>

                                        <div class="tg-description">
                                            <p></p>
                                            <!--<p>Arure dolor in reprehenderit in voluptate velit esse cillum dolore fugiat nulla aetur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia serunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus... <a href="javascript:void(0);">More</a></p>-->
                                        </div>
                                        <div class="tg-sectionhead">
                                            <h2>Product Details</h2>
                                        </div>
                                        <ul class="list-unstyled tg-productinfo">
                                            <li class="d-flex justify-content-between align-items-start py-2 border-bottom bg-light">
                                                <span class="font-weight-bold text-dark">Format:</span>
                                                <span class="text-secondary">${productdetail.format}</span>
                                            </li>
                                            <li class="d-flex justify-content-between align-items-start py-2 border-bottom">
                                                <span class="font-weight-bold text-dark">Pages:</span>
                                                <span class="text-secondary">${productdetail.pages}</span>
                                            </li>
                                            <li class="d-flex justify-content-between align-items-start py-2 border-bottom bg-light">
                                                <span class="font-weight-bold text-dark">Dimensions:</span>
                                                <span class="text-secondary">${productdetail.dimensions}</span>
                                            </li>
                                            <li class="d-flex justify-content-between align-items-start py-2 border-bottom">
                                                <span class="font-weight-bold text-dark">Publication Date:</span>
                                                <span class="text-secondary">${productdetail.publicationDate}</span>
                                            </li>
                                            <li class="d-flex justify-content-between align-items-start py-2 border-bottom bg-light">
                                                <span class="font-weight-bold text-dark">Language:</span>
                                                <span class="text-secondary">${productdetail.language}</span>
                                            </li>
                                            <li class="d-flex justify-content-between align-items-start py-2">
                                                <span class="font-weight-bold text-dark">Description:</span>
                                                <span class="text-secondary">${productdetail.getProduct().description}</span>
                                            </li>
                                        </ul>



                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="tg-aboutauthor">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-left: 120px; margin-top: 30px">
                <div class="tg-sectionhead" style="margin-left: 20px">
                    <h2>Reviews</h2>
                </div>

                <div class="tg-authorbox">
                    <c:forEach var="object" items="${reviewer}">
                        <div class="tg-authorinfo">
                            <div class="tg-review">
                                <div class="tg-leftarea">
                                    <div class="tg-authorname">
                                        <h2>${object.getUserName()}</h2>
                                        <span>${object.getDate()}</span>
                                    </div>
                                    <div>
                                        <ul class="ratings">
                                            <c:forEach var="i" begin="1" end="5">
                                                <c:choose>
                                                    <c:when test="${i <= object.rating}">
                                                        <i class="bi bi-star-fill star-gold" style="color:#FFD700;"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-star text-secondary"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div> 
                        </div>
                        <div class="tg-comment">
                            <p class="mb-0">${object.comment}</p>
                        </div>
                    </c:forEach>

                </div>
                <!-- cần có Bootstrap Icons -->
                <!-- cần Bootstrap Icons -->


                <form method="post" action="${pageContext.request.contextPath}/ReviewServlet">
                    <h4>Your review</h4>

                    <!-- chọn sao -->
                    <div id="rating" style="font-size:26px;cursor:pointer;color:#ccc;">
                        <i class="bi bi-star" data-value="1"></i>
                        <i class="bi bi-star" data-value="2"></i>
                        <i class="bi bi-star" data-value="3"></i>
                        <i class="bi bi-star" data-value="4"></i>
                        <i class="bi bi-star" data-value="5"></i>
                    </div>

                    <input type="hidden" name="star" id="stars_submit">
                    <input type="hidden" name="id" value="${param.productId}">
                    <!-- lấy thẳng id trên thanh url -->
                    <textarea name="content" placeholder="Enter review..." 
                              style="width:100%;height:100px;resize:none;margin-top:10px;"></textarea>
                    <br>
                    <input type="submit" value="Submit" class="btn btn-warning" style="margin-top: 30px; padding: 10px">
                </form>

                <style>
                    #rating i {
                        transition: color 0.2s;
                    }
                    #rating i.active {
                        color: gold;
                    }
                </style>

                <script>
                    const stars = document.querySelectorAll('#rating i');
                    const hidden = document.getElementById('stars_submit');
                    stars.forEach(function (s, i) {
                        s.onclick = function () {
                            hidden.value = i + 1;
                            stars.forEach(function (st, j) {
                                st.classList.toggle('active', j <= i);
                                st.className = 'bi ' + (j <= i ? 'bi-star-fill active' : 'bi-star');
                            });
                        };
                    })
                            ;

                </script>


            </div>
        </div>
    </div>
    <!--************************************
                    News Grid End
    *************************************-->
</main>
<!--************************************
                Main End
*************************************-->

<%@include file="../includes/footer.jsp" %>
