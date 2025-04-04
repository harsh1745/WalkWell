<%@ page import="java.sql.*" %>
<%
            String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
            String dbUser = "root";
            String dbPassword = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                String invoiceQuery = "SELECT i.invoice_id, i.order_id, i.invoice_date, u.username AS username "
                        + "FROM invoices i "
                        + "JOIN users u ON i.user_id = u.user_id "
                        + "ORDER BY i.invoice_date DESC";
                PreparedStatement invoiceStmt = conn.prepareStatement(invoiceQuery);
                ResultSet invoiceRs = invoiceStmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Invoices</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../fontawesome/css/all.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(to right, #eb5d1e, #ECDFCC);
            }
            .invoice-container {
                margin: 75px auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                max-width: 1000px;
            }
            .invoice-header {
                font-size: 40px;
                font-weight: 600;
                margin-bottom: 30px;
                color: #eb5d1e;
                text-align: center;
            }
            .invoice-table {
                width: 100%;
                border-collapse: collapse;
            }
            .invoice-table th, .invoice-table td {
                padding: 15px;
                text-align: center;
            }
            .invoice-table th {
                background-color: #eb5d1e;
                color: white;
                font-size: 16px;
            }
            .invoice-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .invoice-table tr:hover {
                background-color: #f1f1f1;
            }
            .btn-primary {
                background-color: #007bff;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                color: white;
                cursor: pointer;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminSidebar.jsp" %>
        <%@include file="AdminTopNavbar.jsp" %>
        <div class="invoice-container">
            <div class="invoice-header">All Invoices</div>
            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>User Name</th>
                        <th>Invoice Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            while (invoiceRs.next()) {
                                int orderId = invoiceRs.getInt("order_id");
                                String invoiceDate = invoiceRs.getString("invoice_date");
                                String userName = invoiceRs.getString("username");
                    %>
                    <tr>
                        <td><%= userName%></td>
                        <td><%= invoiceDate%></td>
                        <td>
                            <a href="AdminViewInvoice.jsp?orderId=<%= orderId%>" class="btn btn-primary">View Invoice</a>
                        </td>
                    </tr>
                    <%
                            }
                    %>
                </tbody>
            </table>
        </div>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
    </body>
</html>
<%
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
%>