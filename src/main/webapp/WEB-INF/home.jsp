<%@page import="model.Book"%>
<%@page import="model.UserReview"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../WEB-INF/includes/headerTotal.jsp" %>


<!--************************************
                Best Selling Start
*************************************-->
<section class="tg-sectionspace tg-haslayout">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="tg-sectionhead" >
                    <div style="width: 1145px">                   
                        <h2><span>People’s Choice</span>Bestselling Books</h2>
                        <a class="tg-btn" href="javascript:void(0); ">View All</a>
                    </div> 
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">


                <div id="tg-bestsellingbooksslider" class="tg-bestsellingbooksslider tg-bestsellingbooks owl-carousel">

                    <%
                        List<Book> list = (List<Book>) request.getAttribute("bookList");
                        List<UserReview> ratings = (List<UserReview>) request.getAttribute("rw");

                        if (list != null && !list.isEmpty()) {
                            for (Book b : list) {

                    %>
                    <div class="item h-100">
                        <div class="tg-postbook d-flex flex-column justify-content-between h-100 p-3 border rounded bg-white shadow-sm" style="min-height: 520px;">

                            <!-- Hình ảnh -->
                            <figure class="tg-featureimg text-center mb-3">
                                <div class="tg-bookimg position-relative">
                                    <div class="tg-frontcover">
                                        <img src="<%=b.getImg()%>" alt="<%=b.getAuthor_name()%>" class="img-fluid" style="width:180px; height:240px; object-fit:cover;">
                                    </div>
                                </div>
                            </figure>

                            <!-- Nội dung -->
                            <div class="tg-postbookcontent d-flex flex-column flex-grow-1 justify-content-between">
                                <div>
                                    <ul class="tg-bookscategories list-unstyled mb-1">
                                        <li><a href="#"><%=b.getCategory_name()%></a></li>
                                    </ul>

                                    <!-- Tên sản phẩm -->
                                    <div class="tg-booktitle">
                                        <h3 class="mb-1" style="
                                            font-size:16px;
                                            height: 40px;
                                            overflow: hidden;
                                            text-overflow: ellipsis;
                                            display: -webkit-box;
                                            -webkit-line-clamp: 2;
                                            -webkit-box-orient: vertical;">
                                            <a href="http://localhost:8080/Lib/ProductDetail?productId=<%=b.getProductDetail().getId()%>" class="text-dark"><%=b.getName_product()%></a>
                                        </h3>
                                    </div>
                                    <%

                                        double avgRating = 0;
                                        
                                        if (ratings != null && !ratings.isEmpty()) {
                                            int sum = 0;
                                            int count=0;
                                            for (UserReview r : ratings) {
                                                if (r.getSku().equals(b.getSku_product())) {
                                                    sum += r.getRating();
                                                    count+=1;
                                                }
                                            }                                         
                                                avgRating = (double) sum / count;                                          
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
                                    <!-- Tác giả -->
                                    <span class="tg-bookwriter d-block mb-2" style="
                                          font-size:13px;
                                          color:#666;
                                          height: 18px;
                                          overflow: hidden;
                                          white-space: nowrap;
                                          text-overflow: ellipsis;
                                          display: block;">
                                        By: <a href="#"><%=b.getAuthor_name()%></a>
                                    </span>
                                </div>

                                <!-- Giá + mô tả + nút -->
                                <div class="mt-auto">
                                    <span class="tg-bookprice d-block mb-2 font-weight-bold">
                                        <ins> <%=b.getPrice_product()%> $</ins>
                                    </span>

                                    <p class="mb-2" style="
                                       font-size:13px;
                                       color:#555;
                                       height: 40px;
                                       overflow: hidden;
                                       text-overflow: ellipsis;
                                       display: -webkit-box;
                                       -webkit-line-clamp: 2;
                                       -webkit-box-orient: vertical;">
                                        <%=b.getDescription()%>
                                    </p>

                                    <a class="tg-btn tg-btnstyletwo btn btn-outline-primary btn-block" href="javascript:void(0);">
                                        <i class="fa fa-shopping-basket"></i>
                                        <em class="quan1" data-sku="<%=b.getSku_product()%>" style="cursor: pointer">Thêm Vào Giỏ</em>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }

                    } else {
                    %>                            
                    <div class="col-12 text-center">
                        <p>Không có sản phẩm nào.</p>
                    </div>
                    <% }%>
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
                    <figure><img src="${Top1.img}" alt="image description" style="width: 240px"></figure>
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
