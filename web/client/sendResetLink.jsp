<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
        String query = "SELECT * FROM users WHERE email = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            String resetToken = java.util.UUID.randomUUID().toString(); // Unique token
            session.setAttribute("resetToken", resetToken);
            session.setAttribute("resetEmail", email);
            response.sendRedirect("resetPassword.jsp");
        } else {
            response.sendRedirect("forgotPassword.jsp?error=Email not found!");
        }
    } catch (Exception e) {
        response.sendRedirect("forgotPassword.jsp?error=Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>