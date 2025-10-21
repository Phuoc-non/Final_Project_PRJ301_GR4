<%-- 
    Document   : productdetail
    Created on : Oct 15, 2025, 2:33:11 PM
    Author     : Asus
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
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
                                                    <th>STT</th>
                                                    <th>Tên sách</th>
                                                    <th>Hình ?nh</th>
                                                    <th>??n giá</th>
                                                    <th>S? l??ng</th>
                                                    <!-- <th>Thành ti?n</th> -->
                                                    <th>Hành ??ng</th>
                                                </tr>
                                            </thead>
                                            <tbody >
                                              
                                                <tr class="active-row" th:each="detail: ">
                                                    <input type="hidden" th:id="" 
                                                      th:value="" >
                                                        <td th:text=""></td>
                                                        <td th:text=""></td>
                                                        <td><img th:src="" alt="image description" style="height: 100px;"></td>
                                                        <td th:text="" style="font-size : 15px"></td>
                                                        <td> <input type="number" th:name="" min="1" 
                                                        			th:value= style="width: 80px; margin-top: 5px;" 
                                                              th:id="" 
                                                              th:onchange="">
                                                        </td>
                                                        <td>
                                                           	<a th:href="">
                                                               	<button type="button" class="btn btn-danger" style="width: 80px;">Xóa</button>
                                                           	</a>
                                                        </td>
                                                  </tr>
                                                  
                                                  <tr>
                                                  <td colspan="7" >
                                                      <button  class="btn btn-primary"  style="background: green; width: 200px; margin-bottom: 5px; margin-top: 5px;" 
                                                        type="submit">??t hàng</button>
                                                  </td>
                                                  </tr>
                                              
                                            </tbody>
                                        </table>
                                    </form>
                                    </th:block>
                                    <th:block th:if="">
                                         <h5 style="color: red; margin-top: 5px;">Hi?n t?i gi? sách tr?ng</h5>
                                     </th:block>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </main>
    
<%@include file="../includes/footer.jsp" %>