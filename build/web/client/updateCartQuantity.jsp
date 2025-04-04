<%@ page import="java.sql.*" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
    int userId = (Integer) session.getAttribute("user_id");
    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String fetchQuantitySql = "SELECT quantity FROM user_cart WHERE user_id = ? AND product_id = ?";
        PreparedStatement fetchQuantityStmt = conn.prepareStatement(fetchQuantitySql);
        fetchQuantityStmt.setInt(1, userId);
        fetchQuantityStmt.setInt(2, productId);
        ResultSet rs = fetchQuantityStmt.executeQuery();
        int oldQuantity = 0;
        if (rs.next()) {
            oldQuantity = rs.getInt("quantity");
        }
        String stockSql = "SELECT stock FROM products WHERE product_id = ?";
        PreparedStatement stockStmt = conn.prepareStatement(stockSql);
        stockStmt.setInt(1, productId);
        ResultSet stockRs = stockStmt.executeQuery();
        if (stockRs.next()) {
            int availableStock = stockRs.getInt("stock");
            int totalQuantityRequested = newQuantity;
            if (totalQuantityRequested > availableStock + oldQuantity) {
                out.print("error: Only " + availableStock + " available in stock");
                return;
            }
        }
        int quantityDifference = newQuantity - oldQuantity;
        String updateCartSql = "UPDATE user_cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
        pstmt = conn.prepareStatement(updateCartSql);
        pstmt.setInt(1, newQuantity);
        pstmt.setInt(2, userId);
        pstmt.setInt(3, productId);
        pstmt.executeUpdate();
        String updateStockSql = "UPDATE products SET stock = stock - ? WHERE product_id = ?";
        PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSql);
        updateStockStmt.setInt(1, quantityDifference);
        updateStockStmt.setInt(2, productId);
        updateStockStmt.executeUpdate();
        out.print("success");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>