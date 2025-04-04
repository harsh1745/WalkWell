<%@ page import="java.sql.*" %>
<%
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
            String dbUser = "root";
            String dbPassword = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Update order status
                String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, status);
                pstmt.setInt(2, orderId);
                pstmt.executeUpdate();

                out.print("success");
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.print("Error: " + e.getMessage());
            }
%>