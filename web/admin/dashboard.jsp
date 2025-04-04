<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page session="true" %>
<%
            if (session.getAttribute("email") == null) {
                response.sendRedirect("adminlogin.jsp");
            }
%>
<%@include file="AdminSidebar.jsp" %>
<%@include file="AdminTopNavbar.jsp" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel</title>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <style>
            .container-fluid {
                margin-left: 260px;
            }
            .card {
                transition: transform 0.2s;
            }
            .card:hover {
                transform: scale(1.05);
            }
        </style>
    </head>
    <body style="background: linear-gradient(to right, #eb5d1e, #ECDFCC);">
        <div class="d-flex">
            <div class="container-fluid p-4">
                <h1 class="mb-4" style="color: #ECDFCC;">Dashboard</h1>
                <p style="margin-top: -20px; color: #ECDFCC;">Whole data about your business here</p>
                <div class="row">
                    <%
                                String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                                String dbUser = "root";
                                String dbPassword = "";
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                                    // User count query
                                    String userSql = "SELECT COUNT(*) AS user_count FROM users";
                                    Statement userStmt = conn.createStatement();
                                    ResultSet userRs = userStmt.executeQuery(userSql);
                                    int userCount = userRs.next() ? userRs.getInt("user_count") : 0;
                                    // Total orders count query
                                    String totalOrderSql = "SELECT COUNT(*) AS total_order_count FROM orders";
                                    Statement totalOrderStmt = conn.createStatement();
                                    ResultSet totalOrderRs = totalOrderStmt.executeQuery(totalOrderSql);
                                    int totalOrderCount = totalOrderRs.next() ? totalOrderRs.getInt("total_order_count") : 0;
                                    // Pending orders count query
                                    String pendingOrderSql = "SELECT COUNT(*) AS pending_count FROM orders WHERE status = 'pending'";
                                    Statement pendingOrderStmt = conn.createStatement();
                                    ResultSet pendingOrderRs = pendingOrderStmt.executeQuery(pendingOrderSql);
                                    int pendingOrderCount = pendingOrderRs.next() ? pendingOrderRs.getInt("pending_count") : 0;
                                    // Confirmed orders count query
                                    String confirmedOrderSql = "SELECT COUNT(*) AS confirmed_count FROM orders WHERE status = 'Delivered'";
                                    Statement confirmedOrderStmt = conn.createStatement();
                                    ResultSet confirmedOrderRs = confirmedOrderStmt.executeQuery(confirmedOrderSql);
                                    int confirmedOrderCount = confirmedOrderRs.next() ? confirmedOrderRs.getInt("confirmed_count") : 0;
                                    // Shipped orders count query
                                    String shippedOrderSql = "SELECT COUNT(*) AS shipped_count FROM orders WHERE status = 'shipped'";
                                    Statement shippedOrderStmt = conn.createStatement();
                                    ResultSet shippedOrderRs = shippedOrderStmt.executeQuery(shippedOrderSql);
                                    int shippedOrderCount = shippedOrderRs.next() ? shippedOrderRs.getInt("shipped_count") : 0;
                                    // Contact Us count query
                                    String contactSql = "SELECT COUNT(*) AS contact_count FROM contact_us";
                                    Statement contactStmt = conn.createStatement();
                                    ResultSet contactRs = contactStmt.executeQuery(contactSql);
                                    int contactCount = contactRs.next() ? contactRs.getInt("contact_count") : 0;
                                    // Feedback count query
                                    String feedbackSql = "SELECT COUNT(*) AS feedback_count FROM feedback";
                                    Statement feedbackStmt = conn.createStatement();
                                    ResultSet feedbackRs = feedbackStmt.executeQuery(feedbackSql);
                                    int feedbackCount = feedbackRs.next() ? feedbackRs.getInt("feedback_count") : 0;
                                    // Product count query
                                    String productSql = "SELECT COUNT(*) AS product_count FROM products";
                                    Statement productStmt = conn.createStatement();
                                    ResultSet productRs = productStmt.executeQuery(productSql);
                                    int productCount = productRs.next() ? productRs.getInt("product_count") : 0;
                                    // Total sales query
                                    String salesSql = "SELECT SUM(total_amount) AS total_sales FROM orders WHERE status = 'pending'";
                                    Statement salesStmt = conn.createStatement();
                                    ResultSet salesRs = salesStmt.executeQuery(salesSql);
                                    double totalSales = salesRs.next() ? salesRs.getDouble("total_sales") : 0.0;
                                    // Total invoices count query
                                    String invoiceSql = "SELECT COUNT(*) AS invoice_count FROM invoices";
                                    Statement invoiceStmt = conn.createStatement();
                                    ResultSet invoiceRs = invoiceStmt.executeQuery(invoiceSql);
                                    int invoiceCount = invoiceRs.next() ? invoiceRs.getInt("invoice_count") : 0;
                                    conn.close();
                    %>
                    <!-- User Count -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #17a2b8;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= userCount%></h2>
                                    <p class="mb-0">User Count</p>
                                </div>
                                <i class="fas fa-users fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminUsers.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Total Orders -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #6c757d;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= totalOrderCount%></h2>
                                    <p class="mb-0">Total Orders</p>
                                </div>
                                <i class="fas fa-shopping-cart fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminOrders.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Pending Orders -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #ffc107;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= pendingOrderCount%></h2>
                                    <p class="mb-0">Pending Orders</p>
                                </div>
                                <i class="fas fa-clock fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminOrders.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Confirmed Orders -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #28a745;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= confirmedOrderCount%></h2>
                                    <p class="mb-0">Confirmed Orders</p>
                                </div>
                                <i class="fas fa-check-circle fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminOrders.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Shipped Orders -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #6c757d;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= shippedOrderCount%></h2>
                                    <p class="mb-0">Shipped Orders</p>
                                </div>
                                <i class="fas fa-truck fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminOrders.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Contact Us Count -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #dc3545;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= contactCount%></h2>
                                    <p class="mb-0">Contact Us</p>
                                </div>
                                <i class="fas fa-envelope fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminContact.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Feedback Count -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #6610f2;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= feedbackCount%></h2>
                                    <p class="mb-0">Feedback</p>
                                </div>
                                <i class="fas fa-comments fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminFeedback.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Product Count -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #fd7e14;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= productCount%></h2>
                                    <p class="mb-0">Products</p>
                                </div>
                                <i class="fas fa-box-open fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="all_products.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Total Sales -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #6f42c1;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><i class="fa-solid fa-indian-rupee-sign"></i><%= String.format("%.2f", totalSales)%></h2>
                                    <p class="mb-0">Total Sales</p>
                                </div>
                                <i class="fas fa-rupee-sign fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="adminOrders.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Total Invoices -->
                    <div class="col-md-3 mb-4">
                        <div class="card shadow-sm text-white" style="background-color: #20c997;">
                            <div class="card-body d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="mb-0"><%= invoiceCount%></h2>
                                    <p class="mb-0">Total Invoices</p>
                                </div>
                                <i class="fas fa-file-invoice fa-2x"></i>
                            </div>
                            <div class="card-footer bg-transparent text-white">
                                <a href="AdminInvoice.jsp" class="text-white text-decoration-none">
                                    More info <i class="fas fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <%
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    %>
                </div>
            </div>
        </div>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
    </body>
</html>