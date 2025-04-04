<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String successMessage = (String) session.getAttribute("success_message");
    if (successMessage != null) {
        out.println("<div style='text-align: center; padding: 10px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 5px; margin: 10px;'>" + successMessage + "</div>");
        session.removeAttribute("success_message");
    }
    int orderId = Integer.parseInt(request.getParameter("orderId"));

    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String invoiceQuery = "SELECT invoice_html FROM invoices WHERE order_id = ?";
        PreparedStatement invoiceStmt = conn.prepareStatement(invoiceQuery);
        invoiceStmt.setInt(1, orderId);
        ResultSet invoiceRs = invoiceStmt.executeQuery();
        if (invoiceRs.next()) {
            String invoiceHtml = invoiceRs.getString("invoice_html");
            out.println(invoiceHtml);
        } else {
            out.println("<p style='color:red;'>Invoice not found.</p>");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
<div style="text-align: center; margin-top: 20px;">
    <a href="../index.jsp" class="btn btn-primary">Back to Invoices</a>
</div>