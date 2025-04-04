<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
    <head>
        <title>Product List</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/products-card.css" rel="stylesheet">
        <script src="../js/aos.js"></script>
        <link href="../css/aos.css" rel="stylesheet">
                <link href="../css/Products.css" rel="stylesheet">
    </head>
    <body style="background-color: #ECDFCC;">
        <%@include file="../client/header.jsp" %>
        <%@include file="../client/navbar.jsp" %>
        <div class="container mt-5">
            <h1 class="mb-4 text-center product-text">Puma Products</h1>
            <div class="row">
                <%                    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                            String dbUser = "root";
                            String dbPassword = "";

                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                                String sql = "SELECT * FROM products WHERE LOWER(brand) = 'puma'";
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery(sql);

                                while (rs.next()) {
                                    int id = rs.getInt("product_id");
                                    String name = rs.getString("name");
//                            String description = rs.getString("description");
                                    double price = rs.getDouble("price");
                                    String imageUrl = rs.getString("image_url");
                %>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="product-card" data-aos="zoom-in">
                        <div class="product-card__image">
                            <img src="../images/<%= imageUrl%>" alt="<%= name%>">
                        </div>
                        <div class="product-card__info">
                            <h2 class="product-card__title"><%= name%></h2>
                            <!--<p class="product-card__description"></p>-->
                            <div class="product-card__price-row">
                                <% if (rs.getInt("stock") > 0) {%>
                                <button class="product-card__btn" onclick="addToCart(<%= id%>)">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </button>
                                <a href="product_details.jsp?id=<%= id%>" class="product-card__btn">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </a>
                                <% } else {%>
                                <p style="color: red;">No Stock</p>
                                <% }%>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                                }
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                %>
            </div>
        </div>
 <%@include file="footer.jsp" %>
        <script>
            function addToCart(productId) {
                $.ajax({
                    url: "addToCart.jsp",
                    type: "POST",
                    data: {id: productId},
                    success: function (response) {
                        alert("Product added to cart!");
                        $("#cart-count").text(response); // Navbar me count update
                    }
                });
            }

        </script>
        <script>
            AOS.init({
                duration: 1000, // Animation duration in ms
                once: true // Animation happens only once
            });
        </script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/main.js"></script>
    </body>
</html>
