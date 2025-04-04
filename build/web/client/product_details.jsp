<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Shop Item - Start Bootstrap Template</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/icofont.min.css" rel="stylesheet">
        <link href="../css/navbar.css" rel="stylesheet">
        <link href="../css/home.css" rel="stylesheet">
        <link href="../css/products-card.css" rel="stylesheet">
        <link href="../fontawesome/css/all.css" rel="stylesheet">
        <style>
            .card-img-top {
                width: 500px;
                height: 650px;
                object-fit: cover;
                display: block;
                margin: 0 auto;
                cursor: pointer;
            }
        </style>
    </head>

    <body style="background-color: #ECDFCC;">
        <%@include file="../client/header.jsp" %>
        <%@include file="navbar.jsp" %>
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <%
                    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                    String dbUser = "root";
                    String dbPassword = "";
                    int productId = Integer.parseInt(request.getParameter("id"));
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        String sql = "SELECT * FROM products WHERE product_id = ?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, productId);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            int id = rs.getInt("product_id");
                            String name = rs.getString("name");
                            String category = rs.getString("category");
                            double price = rs.getDouble("price");
                            String description = rs.getString("description");
                            String imageUrl = rs.getString("image_url");
                %>
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6">
                        <img class="card-img-top mb-5 mb-md-0" src="../images/<%= imageUrl%>" 
                             alt="..."/>
                    </div>
                    <div class="col-md-6">
                        <div class="h6"><%= category%></div>  
                        <h1 class="font-weight-bold"><%= name%></h1>
                        <div class="fs-5 mb-5">
                            <span><i class="fa-solid fa-indian-rupee-sign"></i><%= price%></span>
                        </div>
                        <p class="lead"><%= description%></p>
                        <button class="btn btn-outline-dark flex-shrink-0 mt-3" type="button" style="width: 228px;" 
                                onclick="addToCart(<%= id%>)">
                            <i class="fa-solid fa-bag-shopping"></i>
                            Add to cart
                        </button>
                    </div>
                </div>
                <%
                        } else {
                            out.println("<h3>Product not found!</h3>");
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </section>
        <script>
            function addToCart(productId) {
                $.ajax({
                    url: "addToCart.jsp",
                    type: "POST",
                    data: {id: productId},
                    success: function (response) {
                        alert("Product added to cart!");
                        $("#cart-count").text(response);
                    }
                });
            }
        </script>
        <!-- Bootstrap core JS -->
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
        <script src="../js/bootstrap.min.js"></script>
    </body>
</html>
