<%@ page session="true" %>
<%@include file="client/navbarindex.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/icofont.min.css" rel="stylesheet">
        <link href="css/navbar.css" rel="stylesheet">
        <link href="css/home.css" rel="stylesheet">
        <link href="css/products-card.css" rel="stylesheet">
        <link href="css/footer.css" rel="stylesheet">
        <link href="fontawesome/css/all.css" rel="stylesheet">
        <script src="js/sweetalert.min.js"></script>
        <script src="js/aos.js"></script>
        <link href="css/aos.css" rel="stylesheet">
        <link href="css/IndexPage.css" rel="stylesheet">
        <style>
            /* loading  */

            #loading {
                position: fixed;
                width: 100%;
                height: 100vh;
                background: #fff url('images/loader.gif') no-repeat center;
                z-index: 99999;
            }

            body.fade-in {
                animation: fadeInAnimation 1s ease-in-out forwards;
            }

            @keyframes fadeInAnimation {
                from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
            }
            .categories{
                background-color: #ECDFCC;
            }
        </style>
    </head>
    <body onload="load()" style="background-color: #ECDFCC;">
        <!-- loading bar -->
        <div id="loading"></div>
    <header>
        <div class="slider">
            <img src="images/card-image3.jpg" class="active" alt="Shoes 1">
            <img src="images/card-item10.jpg" alt="Shoes 2">
            <img src="images/card-item3.jpg" alt="Shoes 3">
            <img src="images/Nike Air Max 90.jpeg">
            <img src="images/Nike Metcon 7.jpeg">

            <div class="slider-overlay"></div>

            <!-- Navigation Buttons -->
            <div class="slider-nav">
                <button id="prev">&laquo;</button>
                <button id="next">&raquo;</button>
            </div>
        </div>

        <!-- Header Content -->
        <div class="header-content">
            <h1>Welcome to WalkWell</h1>
            <p>Find the latest and most stylish shoes in one place.</p>
            <a href="#shop-now">Shop Now</a>
        </div>
    </header>
    <!-- ======= Featured Collections Section ======= -->
    <section id="featured-collections" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4" style="color: #2C3E50;">Featured Collections</h2>
            <div class="row">
                <!-- Men's Footwear -->
                <div class="col-md-6 mb-4">
                    <a href="client/men.jsp" class="card-link">
                        <div class="card category-card">
                            <img src="images/Nike_React_Infinity_Run_Flyknit.jpg" class="card-img-top" alt="Men's Footwear">
                            <div class="card-body">
                                <h5 class="card-title">Men's Footwear</h5>
                            </div>
                        </div>
                    </a>
                </div>
                <!-- Women's Footwear -->
                <div class="col-md-6 mb-4">
                    <a href="client/women.jsp" class="card-link">
                        <div class="card category-card">
                            <img src="images/women.jpg" class="card-img-top" alt="Women's Footwear">
                            <div class="card-body">
                                <h5 class="card-title">Women's Footwear</h5>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>
    <!-- End Featured Collections Section -->
    <!-- ======= Categories Section ======= -->
    <section id="categories" class="categories">
        <div class="container">
            <div class="section-title">
                <h2>Brands Categories</h2>
                <p>Explore Our Wide Range of Categories</p>
            </div>

            <div class="row">
                <!-- Category 1 -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="category-card" data-aos="zoom-in">
                        <div class="icon">
                            <img src="images/adidas.png" alt="Adidas">
                        </div>
                        <h3>Adidas</h3>
                        <p>Discover high-quality sportswear for all ages.</p>
                    </div>
                </div>

                <!-- Category 2 -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="category-card" data-aos="zoom-in" data-aos-delay="100">
                        <div class="icon">
                            <img src="images/nike.png" alt="Nike">
                        </div>
                        <h3>Nike</h3>
                        <p>Style and performance for men, women, and kids.</p>
                    </div>
                </div>

                <!-- Category 4 -->
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="category-card" data-aos="zoom-in" data-aos-delay="300">
                        <div class="icon">
                            <img src="images/puma.png" alt="puma">
                        </div>
                        <h3>Puma</h3>
                        <p>Durable outdoor footwear for adventurers.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Categories Section -->
    <!-- Testimonials -->
    <section class="py-5"  style="background-color: #ECDFCC;">
        <div class="container">
            <h2 style="color: #2C3E50;">What Our Customers Say</h2>
            <div id="testimonialCarousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <p class="lead">"Amazing quality and super fast delivery!"</p>
                        <h5>- Dev Makwana</h5>
                    </div>
                    <div class="carousel-item">
                        <p class="lead">"The best shoes I've ever bought!"</p>
                        <h5>- Dharmik Makwana</h5>
                    </div>
                    <div class="carousel-item">
                        <p class="lead">"Affordable and stylish designs!"</p>
                        <h5>- Sahil Chavda</h5>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#testimonialCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true" style="color: black;font-size: 25px;"><i class="fa-solid fa-arrow-left"></i></span>
                </a>
                <a class="carousel-control-next" href="#testimonialCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true" style="color: black;font-size: 25px;"><i class="fa-solid fa-arrow-right"></i></span>
                </a>
            </div>
        </div>
    </section>
    <%@include file="client/indexfooter.jsp" %>
    <script>
        var currentSlide = 0;
        var slides = document.querySelectorAll('.slider img');
        var totalSlides = slides.length;
        function showSlide(index) {
            for (var i = 0; i < slides.length; i++) {
                slides[i].classList.remove('active');
            }
            slides[index].classList.add('active');
        }
        document.getElementById('next').addEventListener('click', function () {
            currentSlide = (currentSlide + 1) % totalSlides;
            showSlide(currentSlide);
        });
        document.getElementById('prev').addEventListener('click', function () {
            currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
            showSlide(currentSlide);
        });
        setInterval(function () {
            currentSlide = (currentSlide + 1) % totalSlides;
            showSlide(currentSlide);
        }, 5000);
    </script>

    <script>
        AOS.init({
            duration: 1000,
            once: true
        });</script>
    <script>
        // loading
        window.onload = function () {
            setTimeout(function () {
                document.getElementById('loading').style.display = 'none';
                document.body.classList.add('fade-in');
            }, 1500);
        };
    </script>
    <script src="js/jquery/jquery.min.js"></script>
    <script src="fontawesome/js/all.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>
