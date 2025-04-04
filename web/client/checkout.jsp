<%@ page import="java.sql.*" %>
<%@include file="../client/header.jsp" %>
<%@include file="../client/navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../fontawesome/css/all.css" rel="stylesheet">
        <style>
        body {
            background-color: #ECDFCC;
        }
        .checkout-container {
            max-width: 800px;
            margin: 100px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .checkout-header {
            text-align: center;
            font-size: 35px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #eb5d1e;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            color: #eb5d1e;
        }
        .product-details {
            margin-bottom: 20px;
            padding: 15px;
            color: #181C14;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #eb5d1e;
            border: none;
            padding: 10px;
            font-size: 16px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #d04a0e;
        }
    </style>
</head>
<body>
    <div class="checkout-container">
        <div class="checkout-header">Checkout</div>
        <%
            int index = 0;
            String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
            String dbUser = "root";
            String dbPassword = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                while (request.getParameter("productId" + index) != null) {
                    int productId = Integer.parseInt(request.getParameter("productId" + index));
                    int quantity = Integer.parseInt(request.getParameter("quantity" + index));
                    String size = request.getParameter("size" + index);
                    String sql = "SELECT * FROM products WHERE product_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, productId);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String productName = rs.getString("name");
                        double price = rs.getDouble("price");
                        String imageUrl = rs.getString("image_url");
        %>
        <div class="product-details">
            <h4 style="color:#eb5d1e; ">Product Details</h4>
            <p><strong>Image:</strong> <img src="../images/<%= imageUrl %>" width="100"></p>
            <p><strong>Name:</strong> <%= productName %></p>
            <p><strong>Price:</strong> <i class="fa-solid fa-indian-rupee-sign"></i><%= price %></p>
            <p><strong>Quantity:</strong> <%= quantity %></p>
            <p><strong>Size:</strong> <%= size %></p>
        </div>
        <%
                    }
                    index++;
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>
        <form action="placeOrder.jsp" method="POST">
            <%
                index = 0;
                while (request.getParameter("productId" + index) != null) {
                    int productId = Integer.parseInt(request.getParameter("productId" + index));
                    int quantity = Integer.parseInt(request.getParameter("quantity" + index));
                    String size = request.getParameter("size" + index);
                    double total = 0.0;
                    if (request.getParameter("totals" + index) != null) {
                        total = Double.parseDouble(request.getParameter("totals" + index));
                    }
            %>
            <input type="hidden" name="productId<%= index %>" value="<%= productId %>">
            <input type="hidden" name="quantity<%= index %>" value="<%= quantity %>">
            <input type="hidden" name="size<%= index %>" value="<%= size %>">
            <input type="hidden" name="totals<%= index %>" value="<%= total %>">
            <%
                    index++;
                }
            %>
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="address">Shipping Address</label>
                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" required>
            </div>
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" class="form-control" id="state" name="state" required>
            </div>
            <div class="form-group">
                <label for="zip">ZIP Code</label>
                <input type="text" class="form-control" id="zip" name="zip" required>
            </div>
            <div class="form-group">
                <label for="paymentMethod">Payment Method</label>
                <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                    <option value="credit_card">Credit Card</option>
                    <option value="debit_card">Debit Card</option>
                    <option value="cod">Cash on Delivery (COD)</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Place Order</button>
        </form>
    </div>
    <!-- Bootstrap JS -->
    <script src="../js/bootstrap.min.js"></script>
    <script src="../fontawesome/js/all.js"></script>
</body>
</html>