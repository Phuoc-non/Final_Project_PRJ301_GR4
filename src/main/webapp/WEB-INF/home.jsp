<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../WEB-INF/includes/headerTotal.jsp" %>


<!--************************************
                Best Selling Start
*************************************-->
<section class="tg-sectionspace tg-haslayout">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-sectionhead">
                    <h2><span>People’s Choice</span>Bestselling Books</h2>
                    <a class="tg-btn" href="javascript:void(0);">View All</a>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">


                <div id="tg-bestsellingbooksslider" class="tg-bestsellingbooksslider tg-bestsellingbooks owl-carousel">
                    <c:forEach var="b" items="${bookList}">
                        <div class="item">
                            <div class="tg-postbook">
                                <figure class="tg-featureimg">
                                    <div class="tg-bookimg">
                                        <div class="tg-frontcover">
                                            <img src="${b.img}" alt="${b.name_product}" style="width:180px; height:240px; object-fit:cover;">
                                        </div>
                                        <div class="tg-backcover">
                                            <img src="${b.img}" alt="${b.name_product}" style="width:180px; height:240px; object-fit:cover;">
                                        </div>
                                    </div>
                                </figure>
                                <div class="tg-postbookcontent">
                                    <ul class="tg-bookscategories">
                                        <li><a href="#">${b.category_name}</a></li>
                                    </ul>
                                    <div class="tg-booktitle">
                                        <h3><a href="#">${b.name_product}</a></h3>
                                    </div>
                                    <span class="tg-bookwriter">By: <a href="#">${b.author_name != null ? b.author_name : "Unknown"}</a></span>
                                    <span class="tg-bookprice">
                                        <ins>${b.price_product} $</ins>
                                    </span>
                                    <p style="font-size:13px; color:#555;">${b.description}</p>
                                    <a class="tg-btn tg-btnstyletwo" href="javascript:void(0);">
                                        <i class="fa fa-shopping-basket"></i>
                                        <em>Add To Basket</em>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>


            </div>
        </div>
    </div>
</section>
<!--************************************
                Best Selling End
*************************************-->

<!--************************************
                Featured Item Start
*************************************-->
<section class="tg-bglight tg-haslayout">
    <div class="container">
        <div class="row">
            <div class="tg-featureditm">
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 hidden-sm hidden-xs">
                    <figure><img src="${pageContext.request.contextPath}/assets/images/img-02.png" alt="image description"></figure>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                    <div class="tg-featureditmcontent">
                        <div class="tg-themetagbox"><span class="tg-themetag">featured</span></div>
                        <div class="tg-booktitle">
                            <h3><a href="javascript:void(0);">Things To Know About Green Flat Design</a></h3>
                        </div>
                        <span class="tg-bookwriter">By: <a href="javascript:void(0);">Farrah Whisenhunt</a></span>
                        <span class="tg-stars"><span></span></span>
                        <div class="tg-priceandbtn">
                            <span class="tg-bookprice">
                                <ins>$23.18</ins>
                                <del>$30.20</del>
                            </span>
                            <a class="tg-btn tg-btnstyletwo tg-active" href="javascript:void(0);">
                                <i class="fa fa-shopping-basket"></i>
                                <em>Add To Basket</em>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--************************************
                Featured Item End
*************************************-->
<!--************************************
                New Release Start
*************************************-->

<!--************************************
                New Release End
*************************************-->
<!--************************************
                Collection Count Start
*************************************-->

<!--************************************
                Collection Count End
*************************************-->
<!--************************************
                Picked By Author Start
*************************************-->

<!--************************************
                Picked By Author End
*************************************-->
<!--************************************
                Testimonials Start
*************************************-->
<section class="tg-parallax tg-bgtestimonials tg-haslayout" data-z-index="-100" data-appear-top-offset="600" data-parallax="scroll" data-image-src="${pageContext.request.contextPath}/assets/images/parallax/bgparallax-05.jpg">
    <div class="tg-sectionspace tg-haslayout">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8 col-lg-push-2">
                    <div id="tg-testimonialsslider" class="tg-testimonialsslider tg-testimonials owl-carousel">
                        <div class="item tg-testimonial">
                            <figure><img src="${pageContext.request.contextPath}/assets/images/author/imag-02.jpg" alt="image description"></figure>
                            <blockquote><q>The book is very easy to understand, engaging from start to finish, and leaves many valuable lessons after reading.</q></blockquote>
                            <div class="tg-testimonialauthor">
                                <h3>Sophia Taylor</h3>
                                <span>Marketing Specialist</span>
                                <span class="tg-stars"><span></span></span>

                            </div>
                        </div>
                        <div class="item tg-testimonial">
                            <figure><img src="${pageContext.request.contextPath}/assets/images/author/chan-dung-nam2.jpg" alt="image description"></figure>
                            <blockquote><q>Simple and relatable language, with vivid examples. I feel more mature after reading it.</q></blockquote>
                            <div class="tg-testimonialauthor">
                                <h3>Robert Miller</h3>
                                <span>Photographer</span>
                                <span class="tg-stars"><span></span></span>
                            </div>
                        </div>
                        <div class="item tg-testimonial">
                            <figure><img src="${pageContext.request.contextPath}/assets/images/author/chan-dung-nam3.jpg" alt="image description"></figure>
                            <blockquote><q>A must-have book for your shelf – both useful and inspiring. I finished it in just two days.</q></blockquote>
                            <div class="tg-testimonialauthor">
                                <h3>James Wilson</h3>
                                <span>Lawyer</span>
                                <span class="tg-stars"><span></span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--************************************
                Testimonials End
*************************************-->

<!--************************************
                Call to Action Start
*************************************-->

<!--************************************
                Call to Action End
*************************************-->
<!--************************************
                Latest News Start

************************************
                Latest News End
*************************************-->
</main>

<!--************************************
                Main End
*************************************-->
<!--************************************
                Footer Start
*************************************-->

<%@include file="../WEB-INF/includes/footer.jsp" %>

<!--************************************
                Footer End
*************************************-->
