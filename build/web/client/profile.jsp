<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../fontawesome/css/all.css" rel="stylesheet">
    <style>
        body {
            background-color: #ECDFCC; 
            font-family: Arial, sans-serif;
            padding-top: 56px;
        }
        .profile-container {
            max-width: 800px;
            margin: 75px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); 
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-header h2 {
            color: #eb5d1e; 
            font-size: 28px;
            font-weight: bold;
        }
        .profile-details {
            margin-top: 20px;
        }
        .profile-details p {
            font-size: 16px;
            margin-bottom: 15px;
            color: #181C14;
        }
        .profile-details strong {
            color: #eb5d1e;
        }
        .btn-edit-profile {
            margin-top: 20px;
            width: 100%;
            padding: 12px; 
            font-size: 16px; 
            background-color: #eb5d1e;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-edit-profile:hover {
            background-color: #d04a0e; 
        }
    </style>
</head>
<body style="background-color: #ECDFCC;">
    <%@include file="../client/header.jsp" %>
    <%@include file="../client/navbar.jsp" %> 
    <div class="profile-container">
        <div class="profile-header">
            <h2>User Profile</h2>
        </div>
        <div class="profile-details">
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
                        String userEmail = rs.getString("email");
                        String phone = rs.getString("phone");
                        String address = rs.getString("address");
            %>
            <p><strong>Username:</strong> <%= username %></p>
            <p><strong>Email:</strong> <%= userEmail %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= address %></p>
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
        </div>
        <button class="btn-edit-profile" onclick="window.location.href='editProfile.jsp'">Edit Profile</button>
    </div>
    <!-- Bootstrap JS -->
    <script src="../js/jquery/jquery.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../fontawesome/js/all.js"></script>
</body>
</html>