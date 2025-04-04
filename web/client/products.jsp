<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        select, input {
            padding: 5px;
            margin-right: 10px;
        }
        button {
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .product {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .product img {
            max-width: 100px;
            height: auto;
        }
    </style>
</head>
<body>
    <h1>Products</h1>
    <form action="products.jsp" method="get">
        <label>Filter by Category:</label>
        <select name="category">
            <option value="">All</option>
            <option value="Men">Men</option>
            <option value="Women">Women</option>
        </select>

        <label>Filter by Brand:</label>
        <input type="text" name="brand" placeholder="Enter Brand">

        <button type="submit">Filter</button>
    </form>

    <%
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver"); // Older MySQL driver
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");

            // Build the query dynamically
            StringBuilder query = new StringBuilder("SELECT * FROM products WHERE 1=1");
            if (category != null && !category.isEmpty()) {
                query.append(" AND category = ?");
            }
            if (brand != null && !brand.isEmpty()) {
                query.append(" AND brand LIKE ?");
            }

            pstmt = conn.prepareStatement(query.toString());

            // Set parameters
            int paramIndex = 1;
            if (category != null && !category.isEmpty()) {
                pstmt.setString(paramIndex++, category);
            }
            if (brand != null && !brand.isEmpty()) {
                pstmt.setString(paramIndex++, "%" + brand + "%");
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                String productName = rs.getString("product_name");
                String productBrand = rs.getString("brand");
                String productCategory = rs.getString("category");
                String productImage = rs.getString("image");
                String productDescription = rs.getString("description");
                double productPrice = rs.getDouble("price");
    %>
                <div class="product">
                    <img src="<%= productImage %>" alt="<%= productName %>">
                    <h2><%= productName %></h2>
                    <p><strong>Brand:</strong> <%= productBrand %></p>
                    <p><strong>Category:</strong> <%= productCategory %></p>
                    <p><strong>Description:</strong> <%= productDescription %></p>
                    <p><strong>Price:</strong> $<%= productPrice %></p>
                </div>
                <hr>
    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            // Close resources
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>