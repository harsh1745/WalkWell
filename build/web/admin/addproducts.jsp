<%@include file="AdminTopNavbar.jsp" %>
<%@include file="addproductsidebar.jsp" %>
<%@page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Product</title>
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
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: #181C14; font-weight: bold;">Add Product</h2>
            <%
                        String message = request.getParameter("message");
            %>
            <script>
                const message = "<%= message%>";
                if (message === "success") {
                    alert("Product added successfully!");
                    window.history.replaceState({}, document.title, window.location.pathname);
                } else if (message === "error") {
                    alert("Failed to add product!");
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            </script>
            <form action="AddProductServlet" method="POST" enctype="multipart/form-data">
                <div class="row">
                    <!-- Left Section -->
                    <div class="col-md-6">
                        <div class="form-section shadow">
                            <div class="form-group">
                                <label for="product_name">Product Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="product_name" name="name" placeholder="Enter product name" maxlength="40" required>
                                <small class="form-text text-muted">Do not exceed 40 characters when entering the product name.</small>
                            </div>
                            <div class="form-group">
                                <label for="category">Category <span class="text-danger">*</span></label>
                                <select class="form-control" id="category" name="category" required>
                                    <option value="">Choose category</option>
                                    <option value="sports">Sports Shoes</option>
                                    <option value="casual">Casual Shoes</option>
                                    <option value="sneakers">Sneakers Shoes</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="brand">Brand <span class="text-danger">*</span></label>
                                <select class="form-control" id="brand" name="brand" required>
                                    <option value="">Choose brand</option>
                                    <option value="nike">Nike</option>
                                    <option value="puma">Puma</option>
                                    <option value="adidas">Adidas</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="description">Description <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="description" name="description" rows="4" maxlength="200" required></textarea>
                                <small class="form-text text-muted">Do not exceed 200 characters.</small>
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
                            <input type="file" id="product_images" name="image_url" multiple style="display:none;" required>
                            <div class="upload-preview mt-3" id="preview"></div>
                            <div class="form-group mt-3 size-options">
                                <label>Size <span class="text-danger">*</span></label>
                                <select class="form-control" id="size" name="size" required>
                                    <option value="">Choose sizes</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                </select>
                            </div>
                            <div class="form-group mt-3 size-options">
                                <label>Genders <span class="text-danger">*</span></label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="">Choose Gender</option>
                                    <option value="men">Mens</option>
                                    <option value="women">Womens</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="price">Price <i class="fa-solid fa-indian-rupee-sign"></i> <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="price" name="price" placeholder="Enter product price" step="0.01" min="0" required>
                            </div>
                            <div class="form-group">
                                <label for="stock">Stock <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="stock" name="stock" placeholder="Enter stock quantity" min="0" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Add Product</button>
                </div>
            </form>
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
