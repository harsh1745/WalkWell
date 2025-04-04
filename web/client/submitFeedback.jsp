<%@ page import="java.sql.*" %>
<%
            String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
            String dbUser = "root";
            String dbPassword = "";
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            int rating = Integer.parseInt(request.getParameter("rating"));
            String message = request.getParameter("message");
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                if (rating < 1 || rating > 5) {
                    out.println("<p style='color:red;'>Invalid rating value.</p>");
                    return;
                }
                String sql = "INSERT INTO feedback (user_id, name, email, rating, message) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                pstmt.setString(2, name);
                pstmt.setString(3, email);
                pstmt.setInt(4, rating);
                pstmt.setString(5, message);
                pstmt.executeUpdate();
                response.sendRedirect("feedbackSuccess.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            }
%>