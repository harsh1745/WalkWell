<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("user_id");
    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String invoiceQuery = "SELECT i.invoice_id, i.order_id, i.invoice_date FROM invoices i WHERE i.user_id = ? ORDER BY i.invoice_date DESC";
        PreparedStatement invoiceStmt = conn.prepareStatement(invoiceQuery);
        invoiceStmt.setInt(1, userId);
        ResultSet invoiceRs = invoiceStmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Invoices</title>
    <!-- Bootstrap CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../fontawesome/css/all.css" rel="stylesheet">
    <style>
        body {
            background-color: #ECDFCC;
            padding-top: 56px;
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
            font-size: 28px;
            font-weight: bold;
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
            background-color: #181C14;
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
            background-color: #eb5d1e !important;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #d04a0e !important;
        }
    </style>
</head>
<body style="background-color: #ECDFCC;">
    <%@include file="../client/header.jsp" %>
    <%@include file="../client/navbar.jsp" %>
    <div class="invoice-container">
        <div class="invoice-header">My Invoices</div>
        <table class="invoice-table">
            <thead>
                <tr>
                    <th>Invoice ID</th>
                    <th>Order ID</th>
                    <th>Invoice Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (invoiceRs.next()) {
                        int invoiceId = invoiceRs.getInt("invoice_id");
                        int orderId = invoiceRs.getInt("order_id");
                        String invoiceDate = invoiceRs.getString("invoice_date");
                %>
                <tr>
                    <td><%= invoiceId%></td>
                    <td><%= orderId%></td>
                    <td><%= invoiceDate%></td>
                    <td>
                        <a href="viewInvoice.jsp?orderId=<%= orderId%>" class="btn btn-primary">View Invoice</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <!-- Bootstrap JS -->
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