<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Status</title>
        <!-- Bootstrap CSS -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../fontawesome/css/all.css" rel="stylesheet">
                <style>
            body {
                background-color: #ECDFCC;
                padding-top: 56px;
            }
            .status-container {
                margin: 75px auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                max-width: 1000px;
            }
            .status-header {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 30px;
                color: #eb5d1e;
                text-align: center;
            }
            .status-table {
                width: 100%;
                border-collapse: collapse;
            }
            .status-table th, .status-table td {
                padding: 15px;
                text-align: center;
            }
            .status-table th {
                background-color: #181C14;
                color: white;
                font-size: 16px;
            }
            .status-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .status-table tr:hover {
                background-color: #f1f1f1;
            }
            .status-badge {
                padding: 8px 12px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: bold;
                text-transform: uppercase;
            }
            .status-badge.pending {
                background-color: #ffc107;
                color: #000;
            }
            .status-badge.shipped {
                background-color: #17a2b8;
                color: #fff;
            }
            .status-badge.delivered {
                background-color: #28a745;
                color: #fff;
            }
            .status-badge.cancelled {
                background-color: #dc3545;
                color: #fff;
            }
            .total-amount {
                font-weight: bold;
                color: #eb5d1e;
            }
            .product-link {
                color: #181C14;
                cursor: pointer;
                text-decoration: underline;
            }
            .product-link:hover {
                color: #eb5d1e;
            }
            .product-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }
        </style>
    </head>
    <body style="background-color: #ECDFCC;">
        <%@include file="../client/header.jsp" %>
        <%@include file="../client/navbar.jsp" %>
        <div class="status-container">
            <div class="status-header">Your Order Status</div>
            <table class="status-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product Name</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Total Amount</th>
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
        String sql = "SELECT o.order_id, o.order_date, o.status, o.total_amount, "
                   + "GROUP_CONCAT(p.name SEPARATOR ', ') AS product_names "
                   + "FROM orders o "
                   + "JOIN order_details od ON o.order_id = od.order_id "
                   + "JOIN products p ON od.product_id = p.product_id "
                   + "WHERE o.user_id = ? "
                   + "GROUP BY o.order_id "
                   + "ORDER BY o.order_id DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            int orderId = rs.getInt("order_id");
            String orderDate = rs.getString("order_date");
            String status = rs.getString("status");
            double totalAmount = rs.getDouble("total_amount");
            String productNames = rs.getString("product_names");
%>
<tr>
    <td><%= orderId%></td>
    <td>
        <span class="product-link" onclick="showProductDetails(<%= orderId%>)">
            <%= productNames%>
        </span>
    </td>
    <td><%= orderDate%></td>
    <td>
        <span class="status-badge <%= status.toLowerCase()%>">
            <%= status%>
        </span>
    </td>
    <td class="total-amount"><i class="fa-solid fa-indian-rupee-sign"></i><%= totalAmount%></td>
</tr>
<%
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
                </tbody>
            </table>
        </div>
        <div id="productDetailsModal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Size</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody id="productDetailsBody">
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script>
function showProductDetails(orderId) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "getProductDetails.jsp?orderId=" + orderId, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById("productDetailsBody").innerHTML = xhr.responseText;
            $('#productDetailsModal').modal('show');
        }
    };
    xhr.onerror = function () {
        console.error("Error fetching product details:", xhr.statusText);
    };
    xhr.send();
}
        </script>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
    </body>
</html>