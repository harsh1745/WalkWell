<%@ page import="java.sql.*" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    int userId = (Integer) session.getAttribute("user_id");

    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "UPDATE user_cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, quantity);
        stmt.setInt(2, userId);
        stmt.setInt(3, productId);
        stmt.executeUpdate();
        out.print("success");
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>