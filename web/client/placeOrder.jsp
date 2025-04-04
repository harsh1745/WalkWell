<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("user_id");
    String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        double totalAmount = 0;
        String cartQuery = "SELECT p.price, uc.quantity FROM user_cart uc JOIN products p ON uc.product_id = p.product_id WHERE uc.user_id = ?";
        pstmt = conn.prepareStatement(cartQuery);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            double price = rs.getDouble("price");
            int quantity = rs.getInt("quantity");
            totalAmount += price * quantity;
        }
        String orderSql = "INSERT INTO orders (user_id, total_amount, order_date, status) VALUES (?, ?, NOW(), 'pending')";
        pstmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setInt(1, userId);
        pstmt.setDouble(2, totalAmount);
        pstmt.executeUpdate();
        rs = pstmt.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) {
            orderId = rs.getInt(1);
        }
        String cartDetailsQuery = "SELECT uc.product_id, uc.quantity, uc.size, p.price FROM user_cart uc JOIN products p ON uc.product_id = p.product_id WHERE uc.user_id = ?";
        pstmt = conn.prepareStatement(cartDetailsQuery);
        pstmt.setInt(1, userId);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            int productId = rs.getInt("product_id");
            int quantity = rs.getInt("quantity");
            String size = rs.getString("size");
            double price = rs.getDouble("price");
            String orderDetailsQuery = "INSERT INTO order_details (order_id, product_id, quantity, price, size) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(orderDetailsQuery);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantity);
            pstmt.setDouble(4, price);
            pstmt.setString(5, size != null ? size : "6");
            pstmt.executeUpdate();
        }
        String shippingQuery = "INSERT INTO shipping_details (order_id, full_name, address, city, state, zip, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(shippingQuery);
        pstmt.setInt(1, orderId);
        pstmt.setString(2, request.getParameter("fullName"));
        pstmt.setString(3, request.getParameter("address"));
        pstmt.setString(4, request.getParameter("city"));
        pstmt.setString(5, request.getParameter("state"));
        pstmt.setString(6, request.getParameter("zip"));
        pstmt.setString(7, request.getParameter("paymentMethod"));
        pstmt.executeUpdate();
        String invoiceHtml = generateInvoiceHtml(orderId, userId, conn, request);
        String invoiceSql = "INSERT INTO invoices (order_id, user_id, invoice_html) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(invoiceSql);
        pstmt.setInt(1, orderId);
        pstmt.setInt(2, userId);
        pstmt.setString(3, invoiceHtml);
        pstmt.executeUpdate();
        String clearCartQuery = "DELETE FROM user_cart WHERE user_id = ?";
        pstmt = conn.prepareStatement(clearCartQuery);
        pstmt.setInt(1, userId);
        int rowsDeleted = pstmt.executeUpdate();
        out.println("Rows deleted from user_cart: " + rowsDeleted);
        session.removeAttribute("cart");
        session.setAttribute("order_status", "Order Placed Successfully");
        session.setAttribute("success_message", "Order placed successfully! Your invoice is ready.");
        response.sendRedirect("viewInvoice.jsp?orderId=" + orderId);
    } catch (Exception e) {
        e.printStackTrace();
        out.print("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
<%!
    private String generateInvoiceHtml(int orderId, int userId, Connection conn, HttpServletRequest request) throws SQLException {
        StringBuilder invoiceHtml = new StringBuilder();
        String orderQuery = "SELECT o.order_id, o.user_id, o.order_date, o.total_amount, u.email, u.phone "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.user_id "
                + "WHERE o.order_id = ?";
        PreparedStatement orderStmt = conn.prepareStatement(orderQuery);
        orderStmt.setInt(1, orderId);
        ResultSet orderRs = orderStmt.executeQuery();
        if (orderRs.next()) {
            String orderDate = orderRs.getString("order_date");
            double totalAmount = orderRs.getDouble("total_amount");
            String email = orderRs.getString("email");
            String phone = orderRs.getString("phone");
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zip = request.getParameter("zip");
            String itemsQuery = "SELECT p.name, od.quantity, od.price "
                    + "FROM order_details od "
                    + "JOIN products p ON od.product_id = p.product_id "
                    + "WHERE od.order_id = ?";
            PreparedStatement itemsStmt = conn.prepareStatement(itemsQuery);
            itemsStmt.setInt(1, orderId);
            ResultSet itemsRs = itemsStmt.executeQuery();
            invoiceHtml.append("<html>");
            invoiceHtml.append("<head><title>Invoice</title>");
            invoiceHtml.append("<style>");
            invoiceHtml.append("body { font-family: 'Arial', sans-serif; background-color: #ECDFCC;; margin: 0; padding: 0; }");
            invoiceHtml.append(".invoice-container { max-width: 800px; margin: 20px auto; padding: 30px; background: white; border-radius: 10px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); position: relative; overflow: hidden; }");
            invoiceHtml.append(".invoice-header { text-align: center; margin-bottom: 30px; position: relative; z-index: 1; }");
            invoiceHtml.append(".invoice-header h1 { color: #eb5d1e; margin: 0; font-size: 28px; }");
            invoiceHtml.append(".invoice-header p { color: #181C14; margin: 5px 0; font-size: 14px; }");
            invoiceHtml.append(".invoice-details { display: flex; justify-content: space-between; margin-bottom: 30px; position: relative; z-index: 1; }");
            invoiceHtml.append(".invoice-details div { flex: 1; }");
            invoiceHtml.append(".invoice-details div p { margin: 5px 0; font-size: 14px; color: #555; }");
            invoiceHtml.append(".invoice-table { width: 100%; border-collapse: collapse; margin-bottom: 30px; position: relative; z-index: 1; }");
            invoiceHtml.append(".invoice-table th, .invoice-table td { padding: 12px; border: 1px solid #ddd; text-align: center; }");
            invoiceHtml.append(".invoice-table th { background-color:#181C14; color: #eb5d1e; font-size: 14px; }");
            invoiceHtml.append(".invoice-table tr:nth-child(even) { background-color: #f9f9f9; }");
            invoiceHtml.append(".invoice-table tr:hover { background-color: #f1f1f1; }");
            invoiceHtml.append(".invoice-total { text-align: right; font-size: 18px; font-weight: bold; color: #181C14; margin-top: 20px; position: relative; z-index: 1; }");
            invoiceHtml.append(".invoice-actions { text-align: center; margin-top: 30px; position: relative; z-index: 1; }");
            invoiceHtml.append(".invoice-actions button { padding: 10px 20px; background-color: #eb5d1e; color: #181C14; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }");
            invoiceHtml.append(".invoice-actions button:hover { background-color: #0056b3; }");
            invoiceHtml.append(".watermark { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%) rotate(-45deg); font-size: 60px; font-weight: bold; color: rgba(0, 123, 255, 0.1); z-index: 0; pointer-events: none; }");
            invoiceHtml.append("</style>");
            invoiceHtml.append("</head>");
            invoiceHtml.append("<body>");
            invoiceHtml.append("<div class='invoice-container'>");
            invoiceHtml.append("<div class='watermark'>WalkWell</div>");
            invoiceHtml.append("<div class='invoice-header'>");
            invoiceHtml.append("<h1>Invoice</h1>");
            invoiceHtml.append("<p>Order ID: " + orderId + "</p>");
            invoiceHtml.append("<p>Date: " + orderDate + "</p>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("<div class='invoice-details'>");
            invoiceHtml.append("<div>");
            invoiceHtml.append("<p><strong>Customer Details:</strong></p>");
            invoiceHtml.append("<p>Email: " + email + "</p>");
            invoiceHtml.append("<p>Phone: " + phone + "</p>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("<div>");
            invoiceHtml.append("<p><strong>Shipping Address:</strong></p>");
            invoiceHtml.append("<p>" + fullName + "</p>");
            invoiceHtml.append("<p>" + address + "</p>");
            invoiceHtml.append("<p>" + city + ", " + state + " " + zip + "</p>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("<table class='invoice-table'>");
            invoiceHtml.append("<thead>");
            invoiceHtml.append("<tr>");
            invoiceHtml.append("<th>Product</th>");
            invoiceHtml.append("<th>Quantity</th>");
            invoiceHtml.append("<th>Price</th>");
            invoiceHtml.append("<th>Total</th>");
            invoiceHtml.append("</tr>");
            invoiceHtml.append("</thead>");
            invoiceHtml.append("<tbody>");
            while (itemsRs.next()) {
                String productName = itemsRs.getString("name");
                int quantity = itemsRs.getInt("quantity");
                double price = itemsRs.getDouble("price");
                double total = price * quantity;

                invoiceHtml.append("<tr>");
                invoiceHtml.append("<td>" + productName + "</td>");
                invoiceHtml.append("<td>" + quantity + "</td>");
                invoiceHtml.append("<td><i class='fa-solid fa-indian-rupee-sign'></i>" + price + "</td>");
                invoiceHtml.append("<td><i class='fa-solid fa-indian-rupee-sign'></i>" + total + "</td>");
                invoiceHtml.append("</tr>");
            }
            invoiceHtml.append("</tbody>");
            invoiceHtml.append("</table>");
            invoiceHtml.append("<div class='invoice-total'>");
            invoiceHtml.append("<p>Total Amount: <i class='fa-solid fa-indian-rupee-sign'></i>" + totalAmount + "</p>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("<div class='invoice-actions'>");
            invoiceHtml.append("<button onclick='window.print()'>Print Invoice</button>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("</div>");
            invoiceHtml.append("</body>");
            invoiceHtml.append("</html>");
        }
        return invoiceHtml.toString();
    }
%>