<%@ page import="java.sql.*" %>
<%
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String deleteOrderDetailsSql = "DELETE FROM order_details WHERE order_id = ?";
        PreparedStatement pstmt1 = conn.prepareStatement(deleteOrderDetailsSql);
        pstmt1.setInt(1, orderId);
        pstmt1.executeUpdate();
        String deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";
        PreparedStatement pstmt2 = conn.prepareStatement(deleteOrderSql);
        pstmt2.setInt(1, orderId);
        pstmt2.executeUpdate();
        conn.close();
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    }
%>