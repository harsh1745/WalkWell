<%@ page import="java.sql.*, java.util.*" %>
<%
    int productId = Integer.parseInt(request.getParameter("id"));
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        out.print("error: User not logged in");
        return;
    }
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<Integer>();
        session.setAttribute("cart", cart);
    }
    Connection conn = null;
    PreparedStatement checkStmt = null;
    PreparedStatement updateStmt = null;
    PreparedStatement insertStmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
        String stockSql = "SELECT stock FROM products WHERE product_id = ?";
        PreparedStatement stockStmt = conn.prepareStatement(stockSql);
        stockStmt.setInt(1, productId);
        ResultSet stockRs = stockStmt.executeQuery();
        if (stockRs.next()) {
            int availableStock = stockRs.getInt("stock");
            if (availableStock <= 0) {
                out.print("error: No stock available");
                return;
            }
            String checkQuery = "SELECT * FROM user_cart WHERE user_id = ? AND product_id = ?";
            checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                int quantity = rs.getInt("quantity") + 1;
                if (quantity > availableStock) {
                    out.print("error: Only " + availableStock + " available in stock");
                    return;
                }
                String updateQuery = "UPDATE user_cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
                updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, userId);
                updateStmt.setInt(3, productId);
                updateStmt.executeUpdate();
                String updateStockSql = "UPDATE products SET stock = stock - 1 WHERE product_id = ?";
                PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSql);
                updateStockStmt.setInt(1, productId);
                updateStockStmt.executeUpdate();
            } else {
                String insertQuery = "INSERT INTO user_cart (user_id, product_id, quantity) VALUES (?, ?, 1)";
                insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
                String updateStockSql = "UPDATE products SET stock = stock - 1 WHERE product_id = ?";
                PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSql);
                updateStockStmt.setInt(1, productId);
                updateStockStmt.executeUpdate();
            }
            if (!cart.contains(productId)) {
                cart.add(productId);
                session.setAttribute("cart", cart);
            }
            out.print(cart.size());
        } else {
            out.print("error: Product not found");
        }
    } catch (Exception e) {
        out.print("error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (checkStmt != null) checkStmt.close();
            if (updateStmt != null) updateStmt.close();
            if (insertStmt != null) insertStmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>