<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>All Products</title>
        <link href="../DataTable/datatables.min.css" rel="stylesheet">
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../fontawesome/css/all.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(to right, #eb5d1e, #ECDFCC);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
            }

            .table-container {
                margin: 75px auto;
                padding: 20px;
                background: #fff;
                border-radius: 12px;
            }

            h1 {
                text-align: center;
                font-weight: 600;
                color: #eb5d1e;
                margin-bottom: 20px;
            }

            table.dataTable {
                border-collapse: collapse !important;
                border-radius: 8px !important;
                overflow: hidden;
            }

            table.dataTable thead th {
                background-color: #eb5d1e;
                color: #fff;
                font-weight: bold;
                text-transform: uppercase;
                font-size: 14px;
                border-bottom: none !important;
                text-align: center; /* Center align headers */
            }

            table.dataTable tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s ease;
            }

            table.dataTable tbody tr:hover {
                background-color: #ffd1b8; /* Light orange hover effect */
            }

            table.dataTable tbody td {
                padding: 15px 10px;
                text-align: center; /* Center align content */
                vertical-align: middle;
                font-size: 14px;
            }

            table.dataTable tbody td img {
                width: 80px;
                height: 80px;
                border-radius: 4px;
                object-fit: cover;
            }

            .dataTables_wrapper .dataTables_paginate .paginate_button {
                color: #eb5d1e !important;
                border: 1px solid #eb5d1e !important;
                border-radius: 4px;
                padding: 5px 10px;
                margin: 0 3px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                background: #eb5d1e !important;
                color: #fff !important;
                text-decoration: none;
            }

            .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                background: #eb5d1e !important;
                color: #fff !important;
                font-weight: bold;
            }

            .dataTables_wrapper .dataTables_filter input {
                margin-left: 5px;
                border-radius: 20px;
                padding: 5px 10px;
                border: 1px solid #ced4da;
                transition: border-color 0.3s ease;
            }

            .dataTables_wrapper .dataTables_filter input:focus {
                border-color: #eb5d1e;
                outline: none;
            }

            .dataTables_wrapper .dataTables_length select {
                border-radius: 5px;
                padding: 5px 8px;
                border: 1px solid #ced4da;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminSidebar.jsp" %>
        <%@include file="AdminTopNavbar.jsp" %>
        <div class="container table-container">
            <h1>All Products</h1>
            <table id="productsTable" class="display table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Brand</th>
                        <th>Category</th>
                        <th>Size</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Gender</th>
                        <th>Update</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                                String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                                String dbUser = "root";
                                String dbPassword = "";

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                                    String sql = "SELECT product_id, name, brand, category, size, price, stock, gender, image_url FROM products";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);

                                    while (rs.next()) {
                                        String productId = rs.getString("product_id");
                                        String name = rs.getString("name");
                                        String brand = rs.getString("brand");
                                        String category = rs.getString("category");
                                        String size = rs.getString("size");
                                        double price = rs.getDouble("price");
                                        int stock = rs.getInt("stock");
                                        String gender = rs.getString("gender");
                                        String imageUrl = rs.getString("image_url");
                    %>
                    <tr>
                        <td><%= productId%></td>
                        <td><img src="../images/<%= imageUrl%>" alt="Product Image"></td>
                        <td><%= name%></td>
                        <td><%= brand%></td>
                        <td><%= category%></td>
                        <td><%= size%></td>
                        <td><i class="fa-solid fa-indian-rupee-sign"></i><%= price%></td>
                        <td><%= stock%></td>
                        <td><%= gender%></td>
                        <td>
                            <a href="product_update.jsp?product_id=<%= productId%>" class="btn btn-primary btn-sm">
                                <i class="fas fa-edit"></i> Update
                            </a>
                        </td>
                        <td>
                            <a href="DeleteProductServlet?product_id=<%= productId%>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?');">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                    <%
                                    }
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    %>
                </tbody>
            </table>
        </div>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../DataTable/datatables.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
        <script>
            $(document).ready(function () {
                $('#productsTable').DataTable({
                    "pageLength": 10,
                    "lengthMenu": [5, 10, 25, 50],
                    "ordering": true,
                    "searching": true,
                    "paginate": {
                        "previous": "<i class='fas fa-chevron-left'></i>",
                        "next": "<i class='fas fa-chevron-right'></i>"
                    }
                });
            });
        </script>
    </body>
</html>