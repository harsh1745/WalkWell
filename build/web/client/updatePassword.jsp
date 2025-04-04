<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    String email = (String) session.getAttribute("resetEmail");

    if (newPassword == null || confirmPassword == null || email == null) {
        response.sendRedirect("resetPassword.jsp?error=Invalid request!");
        return;
    }

    if (newPassword.equals(confirmPassword)) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            // Hash the new password
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(newPassword.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            String hashedPassword = hexString.toString();

            // Update password in database
            Class.forName("com.mysql.jdbc.Driver"); // Purana MySQL driver ka use karo
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
            String query = "UPDATE users SET password = ? WHERE email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, email);
            pstmt.executeUpdate();

            // Clear session attributes
            session.removeAttribute("resetToken");
            session.removeAttribute("resetEmail");

            // Redirect to login page with success message
            response.sendRedirect("login.jsp?success=Password updated successfully!");
        } catch (Exception e) {
            response.sendRedirect("resetPassword.jsp?error=Error: " + e.getMessage());
        } finally {
            // Resources close karo
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    } else {
        response.sendRedirect("resetPassword.jsp?error=Passwords do not match!");
    }
%>