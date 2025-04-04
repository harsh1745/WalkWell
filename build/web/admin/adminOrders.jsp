<%@ page import="java.sql.*" %>
<html lang="en">
    <head>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Order Management</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../DataTable/datatables.min.css" rel="stylesheet">
        <style>
            .order-container {
                margin: 75px;
                margin-left: 274px;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            .order-header {
                font-weight: 600;
                text-align: center;
                color: #eb5d1e;
                font-size: 40px;
                margin-bottom: 20px;
            }
            .order-details-modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.5);
            }
            .order-details-content {
                background-color: white;
                margin: 10% auto;
                padding: 20px;
                border-radius: 10px;
                width: 50%;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }
            body {
                background: linear-gradient(to right, #eb5d1e, #ECDFCC);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
            }
            .table-container {
                margin: 30px auto;
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
                text-align: center;
            }
            table.dataTable tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s ease;
            }
            table.dataTable tbody tr:hover {
                background-color: #ffd1b8;
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
        <%@include file="AdminTopNavbar.jsp" %>
        <%@include file="AdminSidebar.jsp" %>
        <div class="order-container">
            <div class="order-header">Order Management</div>
            <table id="ordersTable" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Total Amount</th>
                        <th>Action</th>
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
                                    String sql = "SELECT o.order_id, o.user_id, o.order_date, o.status, o.total_amount "
                                            + "FROM orders o "
                                            + "ORDER BY o.order_id DESC";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);

                                    while (rs.next()) {
                                        int orderId = rs.getInt("order_id");
                                        int userId = rs.getInt("user_id");
                                        String orderDate = rs.getString("order_date");
                                        String status = rs.getString("status");
                                        double totalAmount = rs.getDouble("total_amount");
                    %>
                    <tr>
                        <td><%= orderId%></td>
                        <td><%= userId%></td>
                        <td><%= orderDate%></td>
                        <td>
                            <select onchange="updateOrderStatus(<%= orderId%>, this.value)">
                                <option value="pending" <%= status.equals("pending") ? "selected" : ""%>>Pending</option>
                                <option value="shipped" <%= status.equals("shipped") ? "selected" : ""%>>Shipped</option>
                                <option value="delivered" <%= status.equals("delivered") ? "selected" : ""%>>Delivered</option>
                                <option value="cancelled" <%= status.equals("cancelled") ? "selected" : ""%>>Cancelled</option>
                            </select>
                        </td>
                        <td>₹<%= totalAmount%></td>
                        <td>
                            <button onclick="showOrderDetails(<%= orderId%>)" class="btn btn-primary">View Details</button>
                            <button onclick="removeOrder(<%= orderId%>, this)" class="btn btn-danger">Delete</button>
                            <button onclick="refreshPage()" class="btn btn-secondary">Refresh</button>
                        </td>
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
        <!-- Modal for Order Details -->
        <div id="orderDetailsModal" class="order-details-modal">
            <div class="order-details-content">
                <span onclick="closeModal()" style="float: right; cursor: pointer; font-size: 24px;">&times;</span>
                <h3>Order Details</h3>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Size</th>
                        </tr>
                    </thead>
                    <tbody id="orderDetailsBody">
                    </tbody>
                </table>
            </div>
        </div>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../DataTable/datatables.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script>
            function updateOrderStatus(orderId, status) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "updateOrderStatus.jsp?orderId=" + orderId + "&status=" + status, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var data = xhr.responseText;
                        if (data === "success") {
                            alert("Order status updated successfully!");
                            location.reload(); // Refresh the page to reflect changes
                        } else {
                            alert("Error updating order status: " + data);
                        }
                    }
                };
                xhr.send();
            }

            function showOrderDetails(orderId) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "getOrderDetails.jsp?orderId=" + orderId, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var data = xhr.responseText;
                        document.getElementById("orderDetailsBody").innerHTML = data;
                        document.getElementById("orderDetailsModal").style.display = "block";
                    }
                };
                xhr.send();
            }

            function closeModal() {
                document.getElementById("orderDetailsModal").style.display = "none";
            }

            function removeOrder(orderId, button) {
                if (confirm("Are you sure you want to delete this order?")) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "removeOrder.jsp?orderId=" + orderId, true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            var data = xhr.responseText;
                            if (data === "success") {
                                var table = $('#ordersTable').DataTable();
                                var row = button.closest("tr");
                                table.row(row).remove().draw();
                                alert("Order deleted successfully!");
                            } else {
                                alert("Error deleting order: " + data);
                            }
                        }
                    };
                    xhr.send();
                }
            }

            function refreshPage() {
                location.reload();
            }

            $(document).ready(function () {
                $('#ordersTable').DataTable();
            });
        </script>
    </body>
</html>