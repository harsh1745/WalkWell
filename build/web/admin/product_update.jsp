<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Product</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <style>
                        body{
                 background: linear-gradient(to right, #eb5d1e, #ECDFCC);
}
            .form-section {
                background: #f8f9fa;
                padding: 20px;
                height: 580px;
                border-radius: 8px;
            }
            .upload-section {
                border: 2px dashed #ccc;
                border-radius: 8px;
                text-align: center;
                padding: 20px;
                cursor: pointer;
            }
            .upload-preview {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }
            .upload-preview img {
                width: 80px;
                height: 80px;
                border-radius: 4px;
                object-fit: cover;
            }
            .size-options button {
                margin: 5px;
            }
            .container{
                margin-top: 5rem !important;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminTopNavbar.jsp" %>
        <%@include file="AdminSidebar.jsp" %>
        <div class="container">
            <h2 class="text-center mb-4" style="color: #181C14; font-weight: bold;">Update Product</h2>
            <%
                        String productId = request.getParameter("product_id");
                        if (productId == null || productId.isEmpty()) {
                            response.sendRedirect("all_products.jsp");
                        }
                        String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                        String dbUser = "root";
                        String dbPassword = "";
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                            String sql = "SELECT * FROM products WHERE product_id = ?";
                            PreparedStatement stmt = conn.prepareStatement(sql);
                            stmt.setString(1, productId);
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                String name = rs.getString("name");
                                String category = rs.getString("category");
                                String brand = rs.getString("brand");
                                String description = rs.getString("description");
                                String size = rs.getString("size");
                                String gender = rs.getString("gender");
                                double price = rs.getDouble("price");
                                int stock = rs.getInt("stock");
                                String imageUrl = rs.getString("image_url");
            %>
            <form action="UpdateProductServlet" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="product_id" value="<%= productId%>">
                <div class="row">
                    <!-- Left Section -->
                    <div class="col-md-6">
                        <div class="form-section shadow">
                            <div class="form-group">
                                <label for="product_name">Product Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="product_name" name="name" value="<%= name%>" required>
                            </div>
                            <div class="form-group">
                                <label for="category">Category <span class="text-danger">*</span></label>
                                <select class="form-control" id="category" name="category" required>
                                    <option value="sports" <%= category.equals("sports") ? "selected" : ""%>>Sports Shoes</option>
                                    <option value="casual" <%= category.equals("casual") ? "selected" : ""%>>Casual Shoes</option>
                                    <option value="sneakers" <%= category.equals("sneakers") ? "selected" : ""%>>Sneakers Shoes</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="brand">Brand <span class="text-danger">*</span></label>
                                <select class="form-control" id="brand" name="brand" required>
                                    <option value="nike" <%= brand.equals("nike") ? "selected" : ""%>>Nike</option>
                                    <option value="adidas" <%= brand.equals("adidas") ? "selected" : ""%>>Adidas</option>
                                    <option value="puma" <%= brand.equals("puma") ? "selected" : ""%>>Puma</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="description">Description <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="description" name="description" rows="4" required><%= description%></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Right Section -->
                    <div class="col-md-6">
                        <div class="form-section shadow">
                            <label>Upload Images <span class="text-danger">*</span></label>
                            <div class="upload-section" onclick="document.getElementById('product_images').click();">
                                Drop your images here or click to browse
                            </div>
                            <input type="file" id="product_images" name="image_url" multiple style="display:none;">
                            <div class="upload-preview mt-3" id="preview">
                                <img src="../images/<%= imageUrl%>" alt="Product Image" width="80" height="80">
                            </div>
                            <div class="form-group mt-3">
                                <label for="size">Size <span class="text-danger">*</span></label>
                                <select class="form-control" id="size" name="size" required>
                                    <option value="6" <%= size.equals("6") ? "selected" : ""%>>6</option>
                                    <option value="7" <%= size.equals("7") ? "selected" : ""%>>7</option>
                                    <option value="6" <%= size.equals("8") ? "selected" : ""%>>8</option>
                                    <option value="7" <%= size.equals("9") ? "selected" : ""%>>9</option>
                                </select>
                            </div>
                            <div class="form-group mt-3">
                                <label for="gender">Gender <span class="text-danger">*</span></label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="men" <%= gender.equals("men") ? "selected" : ""%>>Men</option>
                                    <option value="women" <%= gender.equals("women") ? "selected" : ""%>>Women</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="price">Price <i class="fa-solid fa-indian-rupee-sign"></i> <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="price" name="price" value="<%= price%>" required>
                            </div>
                            <div class="form-group">
                                <label for="stock">Stock <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="stock" name="stock" value="<%= stock%>" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Update Product</button>
                </div>
            </form>
            <%
                            } else {
                                out.println("<p class='text-danger'>Product not found!</p>");
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                        }
            %>
        </div>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script>
            document.getElementById('product_images').addEventListener('change', function(event) {
                var preview = document.getElementById('preview');
                preview.innerHTML = '';
                var files = event.target.files;
                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    var img = document.createElement('img');
                    img.src = URL.createObjectURL(file);
                    preview.appendChild(img);
                }
            });
        </script>
    </body>
</html>