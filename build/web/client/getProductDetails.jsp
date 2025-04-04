<%@ page import="java.sql.*" %>
<%
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "SELECT p.name, od.quantity, od.size, od.price, p.image_url "
                + "FROM order_details od "
                + "JOIN products p ON od.product_id = p.product_id "
                + "WHERE od.order_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, orderId);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String productName = rs.getString("name");
            int quantity = rs.getInt("quantity");
            String size = rs.getString("size");
            double price = rs.getDouble("price");
            String imageUrl = rs.getString("image_url");
%>
<tr>
    <td>
        <img src="../images/<%= imageUrl%>" alt="<%= productName%>" class="product-image">
    </td>
    <td><%= productName%></td>
    <td><%= quantity%></td>
    <td><%= size%></td>
    <td><i class="fa-solid fa-indian-rupee-sign"></i><%= price%></td>
</tr>
<%
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>