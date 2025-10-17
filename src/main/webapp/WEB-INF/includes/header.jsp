<!doctype html>

<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
        
        <script src="${pageContext.request.contextPath}/assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    </head>
    <body>
        <div id="tg-wrapper" class="tg-wrapper tg-haslayout">
            <!--************************************
                            Header Start
            *************************************-->
            <header id="tg-header" class="tg-header tg-haslayout">
                <div class="tg-topbar">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <ul class="tg-addnav">
                                    <li>
                                        <a href="javascript:void(0);">
                                            <i class="icon-envelope"></i>
                                            <em>Contact</em>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);">
                                            <i class="icon-question-circle"></i>
                                            <em>Help</em>
                                        </a>
                                    </li>
                                </ul>
                                <div class="dropdown tg-themedropdown tg-currencydropdown">
                                    <a href="javascript:void(0);" id="tg-currenty" class="tg-btnthemedropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <i class="icon-earth"></i>
                                        <span>Currency</span>
                                    </a>
                                    <ul class="dropdown-menu tg-themedropdownmenu" aria-labelledby="tg-currenty">
                                        <li>
                                            <a href="javascript:void(0);">
                                                <i>£</i>
                                                <span>British Pound</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:void(0);">
                                                <i>$</i>
                                                <span>Us Dollar</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:void(0);">
                                                <i>?</i>
                                                <span>Euro</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="tg-userlogin">
                                    <figure><a href="javascript:void(0);"><img src="${pageContext.request.contextPath}/assets/images/users/img-01.jpg" alt="image description"></a></figure>
                                    <span>Hi, John</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tg-middlecontainer">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <strong class="tg-logo"><a href="index-2.html"><img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="company name here"></a></strong>
                                <div class="tg-wishlistandcart">
                                    <div class="dropdown tg-themedropdown tg-wishlistdropdown">
                                        <a href="javascript:void(0);" id="tg-wishlisst" class="tg-btnthemedropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="tg-themebadge">3</span>
                                            <i class="icon-heart"></i>
                                            <span>Wishlist</span>
                                        </a>
                                        <div class="dropdown-menu tg-themedropdownmenu" aria-labelledby="tg-wishlisst">
                                            <div class="tg-description"><p>No products were added to the wishlist!</p></div>
                                        </div>
                                    </div>
                                    <div class="dropdown tg-themedropdown tg-minicartdropdown">
                                        <a href="javascript:void(0);" id="tg-minicart" class="tg-btnthemedropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="tg-themebadge">3</span>
                                            <i class="icon-cart"></i>
                                            <span>$123.00</span>
                                        </a>
                                        <div class="dropdown-menu tg-themedropdownmenu" aria-labelledby="tg-minicart">
                                            <div class="tg-minicartbody">
                                                <div class="tg-minicarproduct">
                                                    <figure>
                                                        <img src="${pageContext.request.contextPath}/assets/images/users/img-01.jpg" alt="image description">

                                                    </figure>
                                                    <div class="tg-minicarproductdata">
                                                        <h5><a href="javascript:void(0);">Our State Fair Is A Great Function</a></h5>
                                                        <h6><a href="javascript:void(0);">$ 12.15</a></h6>
                                                    </div>
                                                </div>
                                                <div class="tg-minicarproduct">
                                                    <figure>
                                                        <img src="${pageContext.request.contextPath}/images/products/img-02.jpg" alt="image description">

                                                    </figure>
                                                    <div class="tg-minicarproductdata">
                                                        <h5><a href="javascript:void(0);">Bring Me To Light</a></h5>
                                                        <h6><a href="javascript:void(0);">$ 12.15</a></h6>
                                                    </div>
                                                </div>
                                                <div class="tg-minicarproduct">
                                                    <figure>
                                                        <img src="${pageContext.request.contextPath}/images/products/img-03.jpg" alt="image description">

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
                                        </div>
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
                                            <li class="menu-item-has-children">
                                                <a href="user.jsp">Home</a>

                                            </li>
                                            <li class="menu-item-has-children">
                                                <a href="javascript:void(0);">AllBook</a>
                                        </ul>
                                    </div>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            
