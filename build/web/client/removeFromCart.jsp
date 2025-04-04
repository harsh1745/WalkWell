<%@ page import="java.util.*, java.sql.*" %>
<%
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    if (cart != null) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        if (cart.contains(productId)) {
            cart.remove(Integer.valueOf(productId));
        }
        session.setAttribute("cart", cart);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
            String sql = "DELETE FROM user_cart WHERE user_id = ? AND product_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, (Integer) session.getAttribute("user_id"));
            pstmt.setInt(2, productId);
            pstmt.executeUpdate();
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
        out.print("removed");
    }
%>
