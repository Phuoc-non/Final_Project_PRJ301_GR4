<%-- 
    Document   : productdetail
    Created on : Oct 15, 2025, 2:33:11 PM
    Author     : Asus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

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
                        <li><a href="javascript:void(0);">home</a></li>
                        <li><a href="${pageContext.request.contextPath}/assets/product.jsp">Products</a></li>
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
                    <div class="col-xs-12 col-sm-8 col-md-8 col-lg-9 pull-right">
                        <div id="tg-content" class="tg-content">

                            <div class="tg-productdetail">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                        <div class="tg-postbook">

                                            <figure class="tg-featureimg"><img src="${productdetail.img}" alt="image description"></figure>

                                            <div class="tg-postbookcontent">
                                                <span class="tg-bookprice">
                                                    <ins>${productdetail.price}</ins>
                                                    <del>$27.20</del>
                                                </span>
                                                <span class="tg-bookwriter">You save $4.02</span>
                                                <ul class="tg-delevrystock">
                                                    <li><i class="icon-rocket"></i><span>Free delivery worldwide</span></li>
                                                    <li><i class="icon-checkmark-circle"></i><span>Dispatch from the USA in 2 working days </span></li>

                                                </ul>
                                                <div class="tg-quantityholder">
                                                    <em class="minus">-</em>
                                                    <input type="text" class="result" value="0" id="quantity1" name="quantity">
                                                    <em class="plus">+</em>
                                                </div>
                                                <a class="tg-btn tg-active tg-btn-lg" href="javascript:void(0);">Add To Basket</a>


                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                                        <div class="tg-productcontent">
                                            <ul class="tg-bookscategories">
                                                <li><a href="javascript:void(0);">${productdetail.caterogy}</a></li>
                                            </ul>
                                            <div class="tg-themetagbox"><span class="tg-themetag">sale</span></div>
                                            <div class="tg-booktitle">
                                                <h3>${productdetail.getBookName()}</h3>
                                            </div>
                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">${productdetail.author}</a></span>
                                            <span class="tg-stars"><span></span></span>
                                            <span class="tg-addreviews"><a href="javascript:void(0);">Add Your Review</a></span>

                                            <div class="tg-description">
                                                <p>${productdetail.description}</p>
                                                <!--<p>Arure dolor in reprehenderit in voluptate velit esse cillum dolore fugiat nulla aetur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia serunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus... <a href="javascript:void(0);">More</a></p>-->
                                            </div>
                                            <div class="tg-sectionhead">
                                                <h2>Product Details</h2>
                                            </div>
                                            <ul class="tg-productinfo">
                                                <li><span>Format:</span><span>${productdetail.format}</span></li>
                                                <li><span>Pages:</span><span>${productdetail.pages}</span></li>
                                                <li><span>Dimensions:</span><span>${productdetail.dimensions}</span></li>
                                                <li><span>Publication Date:</span><span>${productdetail.publication_date}</span></li>
                                                <li><span>Language:</span><span>English</span></li>
                                            </ul>

                                        </div>
                                    </div>

                                    <div class="tg-aboutauthor">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <div class="tg-sectionhead">
                                                <h2>About Author</h2>
                                            </div>
                                            <div class="tg-authorbox">
                                                <figure class="tg-authorimg">
                                                    <img src="${pageContext.request.contextPath}/assets/images/author/imag-24.jpg" alt="image description">

                                                </figure>
                                                <div class="tg-authorinfo">
                                                    <div class="tg-authorhead">
                                                        <div class="tg-leftarea">
                                                            <div class="tg-authorname">
                                                                <h2>Kathrine Culbertson</h2>
                                                                <span>Author Since: June 27, 2017</span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="tg-description">
                                                        <p>Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation.</p>
                                                    </div>
                                                    <a class="tg-btn tg-active" href="javascript:void(0);">View All Books</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tg-relatedproducts">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <div class="tg-sectionhead">
                                                <h2><span>Related Products</span>You May Also Like</h2>
                                                <a class="tg-btn" href="javascript:void(0);">View All</a>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <div id="tg-relatedproductslider" class="tg-relatedproductslider tg-relatedbooks owl-carousel">
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-01.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-01.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"><span class="tg-themetag">sale</span></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Help Me Find My Stomach</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-02.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-02.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"><span class="tg-themetag">sale</span></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Drive Safely, No Bumping</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-03.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-03.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Let The Good Times Roll Up</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-04.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-04.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"><span class="tg-themetag">sale</span></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Our State Fair Is A Great State Fair</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-05.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-05.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Put The Petal To The Metal</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-06.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-06.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"><span class="tg-themetag">sale</span></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Help Me Find My Stomach</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <div class="tg-postbook">
                                                        <figure class="tg-featureimg">
                                                            <div class="tg-bookimg">

                                                                <div class="tg-frontcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-03.jpg" alt="image description"></div>
                                                                <div class="tg-backcover"><img src="${pageContext.request.contextPath}/assets/images/books/img-03.jpg" alt="image description"></div>

                                                            </div>

                                                        </figure>
                                                        <div class="tg-postbookcontent">
                                                            <ul class="tg-bookscategories">
                                                                <li><a href="javascript:void(0);">Adventure</a></li>
                                                                <li><a href="javascript:void(0);">Fun</a></li>
                                                            </ul>
                                                            <div class="tg-themetagbox"></div>
                                                            <div class="tg-booktitle">
                                                                <h3><a href="javascript:void(0);">Let The Good Times Roll Up</a></h3>
                                                            </div>
                                                            <span class="tg-bookwriter">By: <a href="javascript:void(0);">Angela Gunning</a></span>
                                                            <span class="tg-stars"><span></span></span>
                                                            <span class="tg-bookprice">
                                                                <ins>$25.18</ins>
                                                                <del>$27.20</del>
                                                            </span>
                                                            <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                                                <i class="fa fa-shopping-basket"></i>
                                                                <em>Add To Basket</em>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3 pull-left">
                        <aside id="tg-sidebar" class="tg-sidebar">
                            <div class="tg-widget tg-widgetsearch">
                                <form class="tg-formtheme tg-formsearch">
                                    <div class="form-group">
                                        <button type="submit"><i class="icon-magnifier"></i></button>
                                        <input type="search" name="search" class="form-group" placeholder="Search by title, author, key...">
                                    </div>
                                </form>
                            </div>
                            <div class="tg-widget tg-catagories">
                                <div class="tg-widgettitle">
                                    <h3>Categories</h3>
                                </div>
                                <div class="tg-widgetcontent">
                                    <ul>
                                        <li><a href="javascript:void(0);"><span>Art &amp; Photography</span><em>28245</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Biography</span><em>4856</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Children’s Book</span><em>8654</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Craft &amp; Hobbies</span><em>6247</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Crime &amp; Thriller</span><em>888654</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Fantasy &amp; Horror</span><em>873144</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Fiction</span><em>18465</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Fod &amp; Drink</span><em>3148</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Graphic, Anime &amp; Manga</span><em>77531</em></a></li>
                                        <li><a href="javascript:void(0);"><span>Science Fiction</span><em>9247</em></a></li>
                                        <li><a href="javascript:void(0);"><span>View All</span></a></li>
                                    </ul>
                                </div>
                            </div>


                            <
                        </aside>
                    </div>
                </div>
            </div>
        </div>
        <div class="tg-aboutauthor">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-sectionhead">
                    <h2>Đánh giá</h2>
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
                                                        <i class="bi bi-star-fill text-warning"></i>
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
                    <h4>Đánh giá của bạn</h4>

                    <!-- chọn sao -->
                    <div id="rating" style="font-size:26px;cursor:pointer;color:#ccc;">
                        <i class="bi bi-star" data-value="1"></i>
                        <i class="bi bi-star" data-value="2"></i>
                        <i class="bi bi-star" data-value="3"></i>
                        <i class="bi bi-star" data-value="4"></i>
                        <i class="bi bi-star" data-value="5"></i>
                    </div>

                    <input type="hidden" name="star" id="stars_submit">

                    <textarea name="content" placeholder="Nhập đánh giá..." 
                              style="width:100%;height:100px;resize:none;margin-top:10px;"></textarea>
                    <br>
                    <input type="submit" value="submit" style="margin-top:10px;">
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
                    
                    stars.forEach(function(s, i){
                        s.onclick = function() {
                            hidden.value = i + 1;
                            stars.forEach(function(st, j) {
                                st.classList.toggle('active', j <= i);
                                st.className = 'bi ' + (j <= i ? 'bi-star-fill active' : 'bi-star');
                            });
                        };
                    });

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
