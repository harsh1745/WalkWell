<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
        <style>
        body {
            background-color: #ECDFCC;
            font-family: Arial, sans-serif;
        }
        .edit-profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .edit-profile-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .edit-profile-header h2 {
            color: #eb5d1e;
            font-size: 28px;
            font-weight: bold;
        }
        .edit-profile-form .form-group {
            margin-bottom: 15px;
        }
        .edit-profile-form label {
            font-weight: bold;
            color: #181C14;
        }
        .edit-profile-form input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .btn-update-profile {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            background-color: #eb5d1e;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease; 
        }
        .btn-update-profile:hover {
            background-color: #d04a0e;
        }
    </style>
</head>
<body>
    <div class="edit-profile-container">
        <div class="edit-profile-header">
            <h2>Edit Profile</h2>
        </div>
        <form class="edit-profile-form" action="updateProfile.jsp" method="post">
            <%
                Integer userId = (Integer) session.getAttribute("user_id");
                if (userId == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
                    String query = "SELECT username, email, phone, address FROM users WHERE user_id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, userId);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        String username = rs.getString("username");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        String address = rs.getString("address");
            %>
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= username %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= phone %>" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= address %>" required>
            </div>
            <%
                    } else {
                        out.println("<p style='color:red;'>User not found!</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
            <button type="submit" class="btn-update-profile">Update Profile</button>
        </form>
    </div>
</body>
</html>