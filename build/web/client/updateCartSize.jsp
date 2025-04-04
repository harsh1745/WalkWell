<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        out.print("notLoggedIn");
        return;
    }
    int productId = Integer.parseInt(request.getParameter("productId"));
    String size = request.getParameter("size");
    int userId = (Integer) session.getAttribute("user_id");
    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "UPDATE user_cart SET size = ? WHERE user_id = ? AND product_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, size);
        stmt.setInt(2, userId);
        stmt.setInt(3, productId);
        stmt.executeUpdate();
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>