<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Registration" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    Registration user = (Registration) session.getAttribute("user");
    boolean isLoggedIn = user != null;
    boolean isAdmin = isLoggedIn && user.isIsAdmin(); // Ensure backend sets isAdmin to true for admin users
    String username = isLoggedIn ? user.getUsername() : "";
%>

<!DOCTYPE html>
<head>
    <title>Book Library</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/assets/apple-touch-icon.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/icomoon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jquery-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.carousel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/transitions.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/color.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    

    
</head>
<body class="tg-home tg-homeone">

    <div id="tg-wrapper" class="tg-wrapper tg-haslayout">
        <!--************************************
                        Header Start
        *************************************-->
        <header id="tg-header" class="tg-header tg-haslayout">
            <div class="tg-topbar">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <% if (isLoggedIn) {%>
                            <div class="tg-userlogin dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">

                                    <span>Hi, <%= username%></span>
                                </a>
                                <ul class="dropdown-menu list-unstyled" style="list-style: none; padding-left: 0;">
                                    <li style="list-style: none; margin-bottom:10px;"><a href="profile"><i class="fa-solid fa-user"></i> Account information</a></li>
                                        <% if (!isAdmin) { %>
                                    <li style="list-style: none; margin-bottom:10px;"><a href="${pageContext.request.contextPath}/orders"><i class="fa-solid fa-cart-shopping"></i> Purchase information</a></li>
                                        <% } %>
                                    <li style="list-style: none; margin-bottom:10px;"><a href="logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
                                </ul>
                            </div>
                            <% } else { %>
                            <div class="tg-userlogin">
                                <a href="login"><i class="fa-solid fa-right-to-bracket"></i> Login</a>    |    <a href="register"> <i class="fa-solid fa-user-plus"></i> Register</a>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tg-middlecontainer">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <strong class="tg-logo"><a href="index.jsp"><img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="company name here"></a></strong>
                            <div class="tg-wishlistandcart">
                                <!-- muốn dùng thì xóa cái div dưới<div class="dropdown tg-themedropdown tg-minicartdropdown">-->
                                <div>
                                    <%-- <a href="${pageContext.request.contextPath}/Cart" id="tg-minicart" class="tg-btnthemedropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
                                    <a href="${pageContext.request.contextPath}/cart" id="tg-minicart" class="tg-btnthemedropdown" aria-haspopup="true" aria-expanded="false">

<!--                                        <span class="tg-themebadge">7</span>-->
                                        <i class="icon-cart"></i>
                                        <span>$123.00</span>
                                    </a>
                                    <!--                                        <div class="dropdown-menu tg-themedropdownmenu" aria-labelledby="tg-minicart">
                                                                                <div class="tg-minicartbody">
                                                                                    <div class="tg-minicarproduct">
                                                                                        <figure>
                                                                                            <img src="${pageContext.request.contextPath}/assets/images/products/img-01.jpg" alt="image description">
                                                                                        </figure>
                                                                                        <div class="tg-minicarproductdata">
                                                                                            <h5><a href="javascript:void(0);">Our State Fair Is A Great Function</a></h5>
                                                                                            <h6><a href="javascript:void(0);">$ 12.15</a></h6>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="tg-minicarproduct">
                                                                                        <figure>
                                                                                            <img src="${pageContext.request.contextPath}/assets/images/products/img-02.jpg" alt="image description">
                                                                                        </figure>
                                                                                        <div class="tg-minicarproductdata">
                                                                                            <h5><a href="javascript:void(0);">Bring Me To Light</a></h5>
                                                                                            <h6><a href="javascript:void(0);">$ 12.15</a></h6>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="tg-minicarproduct">
                                                                                        <figure>
                                                                                            <img src="${pageContext.request.contextPath}/assets/images/products/img-03.jpg" alt="image description">
                                                                                        </figure>
                                                                                        <div class="tg-minicarproductdata">
                                                                                            <h5><a href="javascript:void(0);">Have Faith In Your Soul</a></h5>
                                                                                            <h6><a href="javascript:void(0);">$ 12.15</a></h6>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="tg-minicartfoot">
                                                                                    <a class="tg-btnemptycart" href="javascript:void(0);">
                                                                                        <i class="fa fa-trash-o"></i>
                                                                                        <span>Clear Your Cart</span>
                                                                                    </a>
                                                                                    <span class="tg-subtotal">Subtotal: <strong>35.78</strong></span>
                                                                                    <div class="tg-btns">
                                                                                        <a class="tg-btn tg-active" href="javascript:void(0);">View Cart</a>
                                                                                        <a class="tg-btn" href="javascript:void(0);">Checkout</a>
                                                                                    </div>
                                                                                </div>
                                                                            </div>-->
                                </div>
                            </div>
                            <div class="tg-searchbox">
                                <form class="tg-formtheme tg-formsearch">
                                    <fieldset>
                                        <input type="text" name="search" class="typeahead form-control" placeholder="Search by title, author, keyword, ISBN...">
                                        <button type="submit"><i class="icon-magnifier"></i></button>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tg-navigationarea">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <nav id="tg-nav" class="tg-nav">
                                <div class="navbar-header">
                                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#tg-navigation" aria-expanded="false">
                                        <span class="sr-only">Toggle navigation</span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                </div>
                                <div id="tg-navigation" class="collapse navbar-collapse tg-navigation">
                                    <ul>
                                        <li><a href="book">Home</a></li>
                                            <% if (isAdmin) { %>
                                        <li >
                                            <a href="category">All Categories</a>
                                            </li>
                                                   
                                        <li >
                                            <a href="authors">Authors</a>

                                        </li>
                                        <li><a href="bm">Book</a></li>
                                        <li><a href="cutomer">Customer</a></li>
                                        <li><a href="${pageContext.request.contextPath}/orders">Order</a></li>
                                       
                                        <li><a href="promotion">Promotion</a></li>
                                        <li><a href="statistics">Statistic</a></li>
                                            <% } else { %>
                                        <li><a href="ab?cate"  >AllBook</a></li>
                                            <% }%>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>

            </div>
        </header>




        <!--************************************
                        Header End
        *************************************-->

    </div>
