package UpdateProduct;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class UpdateProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
        String dbUser = "root";
        String dbPassword = "";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Check if the request contains multipart content
            if (ServletFileUpload.isMultipartContent(request)) {
                // Create a factory for disk-based file items
                DiskFileItemFactory factory = new DiskFileItemFactory();

                // Configure a repository (to ensure a secure temp location is used)
                File repository = (File) getServletContext().getAttribute("javax.servlet.context.tempdir");
                factory.setRepository(repository);

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);

                // Parse the request
                java.util.List<FileItem> items = upload.parseRequest(request);

                // Process the uploaded items
                String productId = null, name = null, category = null, brand = null, description = null, size = null, gender = null, imageName = null;
                double price = 0;
                int stock = 0;

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        // Process regular form fields
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString();

                        if ("product_id".equals(fieldName)) {
                            productId = fieldValue;
                        } else if ("name".equals(fieldName)) {
                            name = fieldValue;
                        } else if ("category".equals(fieldName)) {
                            category = fieldValue;
                        } else if ("brand".equals(fieldName)) {
                            brand = fieldValue;
                        } else if ("description".equals(fieldName)) {
                            description = fieldValue;
                        } else if ("size".equals(fieldName)) {
                            size = fieldValue;
                        } else if ("gender".equals(fieldName)) {
                            gender = fieldValue;
                        } else if ("price".equals(fieldName)) {
                            price = Double.parseDouble(fieldValue);
                        } else if ("stock".equals(fieldName)) {
                            stock = Integer.parseInt(fieldValue);
                        } else if ("existing_image".equals(fieldName)) {
                            imageName = fieldValue; // Existing image URL
                        }
                    } else {
                        // Process file upload
                        String fileName = new File(item.getName()).getName();
                        if (fileName != null && !fileName.isEmpty()) {
                            // Save only the file name (not the path) to the database
                            imageName = fileName;

                            // Save the file to a directory (optional)
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdir();
                            }
                            item.write(new File(uploadPath + File.separator + fileName));
                        }
                    }
                }

                // Agar user ne koi nayi image upload nahi ki hai, toh existing image URL retain karo
                if (imageName == null || imageName.isEmpty()) {
                    // Fetch existing image URL from the database
                    Connection conn2 = null;
                    PreparedStatement stmt2 = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn2 = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        String sql2 = "SELECT image_url FROM products WHERE product_id = ?";
                        stmt2 = conn2.prepareStatement(sql2);
                        stmt2.setString(1, productId);
                        rs = stmt2.executeQuery();
                        if (rs.next()) {
                            imageName = rs.getString("image_url"); // Existing image URL
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt2 != null) stmt2.close();
                        if (conn2 != null) conn2.close();
                    }
                }

                // Save data to the database
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                String sql = "UPDATE products SET name=?, category=?, brand=?, description=?, size=?, price=?, stock=?, gender=?, image_url=? WHERE product_id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, category);
                stmt.setString(3, brand);
                stmt.setString(4, description);
                stmt.setString(5, size);
                stmt.setDouble(6, price);
                stmt.setInt(7, stock);
                stmt.setString(8, gender);
                stmt.setString(9, imageName);
                stmt.setString(10, productId);

                int row = stmt.executeUpdate();

                if (row > 0) {
                    response.sendRedirect("all_products.jsp?message=success");
                } else {
                    response.sendRedirect("all_products.jsp?message=error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}