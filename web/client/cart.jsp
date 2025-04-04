<%@ page import="java.sql.*, java.util.*" %>
<%@page session="true" %>
<%@include file="../client/header.jsp" %>
<%@include file="../client/navbar.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        out.print("error: User not logged in");
        return;
    }
    List usercart = (List) session.getAttribute("cart");
    if (usercart == null) {
        usercart = new ArrayList();
    }
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
        String query = "SELECT product_id, quantity, size FROM user_cart WHERE user_id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            int productId = rs.getInt("product_id");
            if (!usercart.contains(productId)) {
                usercart.add(productId);
            }
        }
        session.setAttribute("cart", usercart);
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    if (usercart.isEmpty()) {
%>
<div class="empty-cart">
    <img src="../images/emptyCart.jpg" alt="Empty Cart">
    <h2></h2>
    <a href="../index.jsp" class="back-home">Back to Home</a>
</div>
<style>
    .empty-cart {
        text-align: center;
        margin-top: 50px;
    }
    .empty-cart img {
        width: 750px;
        height: auto;
        margin-bottom: 20px;
    }
    .empty-cart h2 {
        font-size: 24px;
        color: #333;
    }
    .back-home {
        display: inline-block;
        padding: 12px 20px;
        font-size: 16px;
        background: #007bff;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        transition: 0.3s;
    }
    .back-home:hover {
        background: #0056b3;
    }
    .size {
        font-size: 16px;
        font-weight: bold;
    }
    .size-increase, .size-decrease {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        border: none;
        background: #ddd;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
    }
    .size-increase:hover, .size-decrease:hover {
        background: #007bff;
        color: white;
    }
</style>
<%
    } else {
        Connection conn2 = null;
        PreparedStatement ps = null;
        ResultSet rs2 = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");

            conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
            ps = conn2.prepareStatement("SELECT * FROM products WHERE product_id = ?");
%>
<html>
    <head>
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <script src="../js/jquery/jquery.min.js"></script>
        <link href="../fontawesome/css/all.css" rel="stylesheet">
        <style>
            body {
    background-color: #ECDFCC;
}
.cart-container {
    max-width:1350px;
    margin: 100px auto;
    padding: 30px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}
.cart-header, .cart-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 15px;
    border-bottom: 1px solid #ddd;
}
.cart-header {
    font-weight: bold;
    background-color: #f1f1f1;
    border-radius: 8px;
}
.cart-item img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
}
.cart-item button {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    border: none;
    background: #ddd;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
}
.cart-item button:hover {
    background: #eb5d1e;
    color: white;
}
.cart-summary {
    margin-top: 20px;
    padding: 20px;
    background: #f9f9f9;
    border-radius: 8px;
}
.cart-summary div {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}
.cart-summary div:last-child {
    margin-bottom: 0;
}
.remove {
    background: #eb5d1e;
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 14px;
    transition: 0.3s;
}
.remove:hover {
    background: #d04a0e;
}
.checkout-btn {
    width: 100%;
    font-size: 18px;
    padding: 12px;
    border-radius: 8px;
    margin-top: 20px;
    background-color: #eb5d1e;
    color: white;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.checkout-btn:hover {
    background-color: #d04a0e;
}
.coupon-section {
    margin-top: 20px;
}
.coupon-section input {
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ddd;
}
.coupon-section button {
    padding: 8px 12px;
    border-radius: 5px;
    border: none;
    background: #eb5d1e;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.coupon-section button:hover {
    background: #d04a0e;
}
            .coupon-section button:hover { background: #0056b3; }
        </style>
    </head>
    <body>
        <div class="cart-container">
            <h2 class="text-center mb-4" style="color: #eb5d1e; font-weight: bold;">Your Shopping Cart</h2>
            <div class="cart-header">
                <span>Images</span>
                <span>Products</span>
                <span>Price</span>
                <span>Quantity</span>
                <span>Size</span>
                <span>Total</span>
                <span>Remove</span>
            </div>
            <div id="cart-items">
                <%
                    double total = 0;
                    for (int i = 0; i < usercart.size(); i++) {
                        int id = (Integer) usercart.get(i);
                        ps.setInt(1, id);
                        rs2 = ps.executeQuery();
                        if (rs2.next()) {
                            double price = rs2.getDouble("price");
                            int stock = rs2.getInt("stock");
                            total += price;
                            String sizeQuery = "SELECT size FROM user_cart WHERE user_id = ? AND product_id = ?";
                            PreparedStatement sizeStmt = conn2.prepareStatement(sizeQuery);
                            sizeStmt.setInt(1, userId);
                            sizeStmt.setInt(2, id);
                            ResultSet sizeRs = sizeStmt.executeQuery();
                            String selectedSize = "N/A";
                            if (sizeRs.next()) {
                                selectedSize = sizeRs.getString("size");
                            }
                %>
                <div class="cart-item" id="item-<%= id%>">
                    <img src="../images/<%= rs2.getString("image_url")%>">
                    <span><%= rs2.getString("name")%></span>
                    <span>₹<%= price%></span>
                    <div>
                        <button class="decrease" data-id="<%= id%>" data-stock="<%= stock%>">-</button>
                        <span class="quantity mx-2" id="qty-<%= id%>">1</span>
                        <button class="increase" data-id="<%= id%>" data-stock="<%= stock%>">+</button>
                    </div>
                    <select class="size-select form-control mb-3" data-id="<%= id%>" style="max-width: 228px;" required>
                        <option value="6" <%= "6".equals(selectedSize) ? "selected" : ""%>>6</option>
                        <option value="7" <%= "7".equals(selectedSize) ? "selected" : ""%>>7</option>
                        <option value="8" <%= "8".equals(selectedSize) ? "selected" : ""%>>8</option>
                        <option value="9" <%= "9".equals(selectedSize) ? "selected" : ""%>>9</option>
                    </select>
                    <span>₹<%= price%></span>
                    <button class="remove" data-id="<%= id%>">X</button>
                </div>
                <%
                        }
                    }
                %>
            </div>

            <div class="cart-summary">
                <div>
                    <span>Subtotal</span>
                    <span>₹<span id="subtotal-price"><%= total%></span></span>
                </div>
            </div>
            <button class="btn btn-primary checkout-btn" onclick="proceedToCheckout()">Proceed To Checkout</button>
        </div>

        <script>
            function proceedToCheckout() {
                var usercartData = [];
                $(".cart-item").each(function() {
                    var productId = $(this).find(".size-select").data("id");
                    var quantity = parseInt($(this).find(".quantity").text());
                    var size = $(this).find(".size-select").val();
                    usercartData.push({ productId: productId, quantity: quantity, size: size });
                });
                var url = "checkout.jsp?";
                for (var i = 0; i < usercartData.length; i++) {
                    url += "productId" + i + "=" + usercartData[i].productId + "&quantity" + i + "=" + usercartData[i].quantity + "&size" + i + "=" + usercartData[i].size + "&";
                }
                window.location.href = url;
            }
        </script>

        <script>
            $(document).ready(function() {
                $(".increase").click(function() {
                    var id = $(this).data("id");
                    var stock = parseInt($(this).data("stock"));
                    var qty = parseInt($("#qty-" + id).text());
                    if (qty < stock) {
                        qty++;
                        $("#qty-" + id).text(qty);
                        updateQuantityInDatabase(id, qty);
                        updateTotal();
                    } else {
                        alert("Only " + stock + " available in stock.");
                    }
                });
                $(".decrease").click(function() {
                    var id = $(this).data("id");
                    var qty = parseInt($("#qty-" + id).text());
                    if (qty > 1) {
                        qty--;
                        $("#qty-" + id).text(qty);
                        updateQuantityInDatabase(id, qty);
                        updateTotal();
                    }
                });
                function updateQuantityInDatabase(productId, quantity) {
                    $.post("updateCartQuantity.jsp", { productId: productId, quantity: quantity }, function(response) {
                        if (response === "success") {
                            console.log("Quantity updated to " + quantity + " for product ID " + productId);
                        } else {
                            console.error("Error updating quantity: " + response);
                        }
                    });
                }
                $(".remove").click(function() {
                    var id = $(this).data("id");
                    $("#item-" + id).fadeOut(300, function() { $(this).remove(); updateTotal(); });
                    removeItemFromCart(id);
                });
                function updateTotal() {
                    var subtotal = 0;
                    $(".cart-item").each(function() {
                        var price = parseFloat($(this).find("span:nth-child(3)").text().replace("₹", ""));
                        var qty = parseInt($(this).find(".quantity").text());
                        var itemTotal = price * qty; // Calculate item total
                        $(this).find("span:nth-child(5)").text("₹" + itemTotal.toFixed(2));
                        subtotal += itemTotal;
                    });
                    $("#subtotal-price").text(subtotal.toFixed(2));
                }
                function removeItemFromCart(id) {
                    $.get("removeFromCart.jsp", { productId: id }, function(response) {
                        if (response == "removed") {
                            updateTotal();
                        }
                    });
                }
            });
        </script>
        <script>
            $(".size-select").change(function() {
                var productId = $(this).data("id");
                var selectedSize = $(this).val();
                if (selectedSize) {
                    // Send selected size to backend
                    $.post("updateCartSize.jsp", { productId: productId, size: selectedSize }, function(response) {
                        if (response === "success") {
                            alert("Size updated to " + selectedSize + " for product ID " + productId);
                        } else {
                            alert("Error updating size: " + response);
                        }
                    });
                }
            });
        </script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/main.js"></script>
    </body>
</html>
<%
            conn2.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>