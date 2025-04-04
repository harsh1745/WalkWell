<%@ page import="java.sql.*" %>
<%
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
            String dbUser = "root";
            String dbPassword = "";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                String sql = "SELECT p.name AS product_name, od.quantity, od.price, od.size "
                        + "FROM order_details od "
                        + "JOIN products p ON od.product_id = p.product_id "
                        + "WHERE od.order_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, orderId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    String productName = rs.getString("product_name");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    String size = rs.getString("size");
%>
<tr>
    <td><%= productName%></td>
    <td><%= quantity%></td>
    <td><i class="fa-solid fa-indian-rupee-sign"></i><%= price%></td>
    <td><%= size%></td>
</tr>
<%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
%>