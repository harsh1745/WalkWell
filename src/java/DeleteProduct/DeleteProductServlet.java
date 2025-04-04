package DeleteProduct;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DeleteProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement stmt2 = null;

        try {
            // Get product_id from request
            String productId = request.getParameter("product_id");

            // Delete product from database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Step 1: Delete references from user_cart table
            String sql1 = "DELETE FROM user_cart WHERE product_id = ?";
            stmt = conn.prepareStatement(sql1);
            stmt.setString(1, productId);
            stmt.executeUpdate();

            // Step 2: Delete product from products table
            String sql2 = "DELETE FROM products WHERE product_id = ?";
            stmt2 = conn.prepareStatement(sql2);
            stmt2.setString(1, productId);

            int row = stmt2.executeUpdate();

            if (row > 0) {
                response.sendRedirect("all_products.jsp?message=deleted");
            } else {
                response.sendRedirect("all_products.jsp?message=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (stmt2 != null) stmt2.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}