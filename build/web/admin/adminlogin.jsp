<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.security.MessageDigest"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <script src="../js/1sweetalert.min.js"></script>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #181C14;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
            .header {
                text-align: center;
                background-color: #eb5d1e
                    padding:40px 0;
                width: 100%;
                color: white;
                font-size: 36px;
                font-weight: bold;
            }
            .login-container {
                display: flex;
                max-width: 900px;
                width: 100%;
                height: 80%;
                margin: 20px;
                background: #ECDFCC;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
                overflow: hidden;
            }
            .left-section, .right-section {
                flex: 1;
                padding: 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            .left-section {
                background: linear-gradient(135deg, #ECDFCC, #eb5d1e);
                color: #181C14;
            }
            .left-section h2 {
                margin-bottom: 20px;
                font-size: 24px;
                font-weight: bold;
            }
            .left-section p {
                margin-bottom: 20px;
                font-size: 14px;
                text-align: center;
                line-height: 1.5;
            }
            .btn-create-account {
                color: #181C14;
                border: none;
                padding: 10px 20px;
                text-transform: uppercase;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                background-color: #ECDFCC;
            }
            .btn-create-account a{
                text-decoration: none;
                color: #181C14;
                padding: 20px;
            }
            .btn-create-account a:hover{
                color: #ECDFCC;
            }

            .btn-create-account:hover {
                background-color: #181C14;
                color: #ECDFCC;
                border: 2px solid #ECDFCC;
            }
            .right-section h2 {
                margin-bottom: 10px;
                font-size: 24px;
                font-weight: bold;
                text-align: center;
                color: #181C14;
            }
            .right-section form {
                width: 100%;
                max-width: 300px;
            }
            .form-group {
                margin-bottom: 20px;
                margin-top: 20px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-size: 14px;
                color: #181C14;
            }
            .form-group input {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                border: 1px solid #181C14;
                border-radius: 4px;
                background-color: #ECDFCC;
                color: #181C14;
            }
            .form-group input[type="checkbox"] {
                width: auto;
                margin-right: 5px;
            }
            .btn-login {
                background-color: transparent;
                color: #181C14;
                border: 2px solid #181C14;
                padding: 10px 20px;
                text-transform: uppercase;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
            }
            .btn-login:hover {
                background-color: #181C14;
                color: #ECDFCC;
            }
            .forgot-pass {
                display: block;
                text-align: center;
                margin-top: 10px;
                font-size: 12px;
                color: #181C14;
            }
            .forgot-pass:hover {
                color: #eb5d1e;
            }
            .popup-message {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%) scale(0.8);
                padding: 15px 30px;
                z-index: 1000;
                color: #fff;
                font-weight: bold;
                border-radius: 10px;
                background-color: #eb5d1e;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.5s ease, visibility 0.5s ease, transform 0.5s ease;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            }
            .popup-success {
                background-color: #4CAF50;
            }
            .popup-error {
                background-color: #f44336;
            }
            .popup-message.show {
                opacity: 1;
                visibility: visible;
                transform: translateX(-50%) scale(1);
                animation: bounceIn 0.5s ease;
            }
            @keyframes bounceIn {
                0% {
                transform: translateX(-50%) scale(0.8);
                opacity: 0;
            }
            50% {
                transform: translateX(-50%) scale(1.1);
                opacity: 1;
            }
            100% {
                transform: translateX(-50%) scale(1);
                opacity: 1;
            }
            }
        </style>
    </head>
    <body>
        <%
                    String popupClass = "";
                    String popupMessage = "";
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    if (email != null && password != null) {
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
                            String query = "SELECT * FROM admins WHERE email = ? AND password = ?";
                            pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, email);
                            pstmt.setString(2, password);
                            rs = pstmt.executeQuery();
                            if (rs.next()) {
                                session.setAttribute("email", email);
                                popupClass = "popup-success";
                                popupMessage = "Login successful! Redirecting Home Page...";
                                response.setHeader("Refresh", "3; URL=dashboard.jsp");
                            } else {
                                popupClass = "popup-error";
                                popupMessage = "Invalid email or password!";
                            }
                        } catch (Exception e) {
                            popupClass = "popup-error";
                            popupMessage = "Error: " + e.getMessage();
                        } finally {
                            if (rs != null) {
                                rs.close();
                            }
                            if (pstmt != null) {
                                pstmt.close();
                            }
                            if (conn != null) {
                                conn.close();
                            }
                        }
                    }
        %>
        <div class="popup-message <%= popupClass%> <%= popupClass.isEmpty() ? "" : "show"%>">
            <%= popupMessage%>
        </div>
        <script>
            window.onload = function () {
                setTimeout(function () {
                    document.getElementById('loading').style.display = 'none';
                    document.body.classList.add('fade-in');
                }, 1500);
            };
        </script>
        <div class="login-container">
            <div class="left-section">
                <h2>Welcome Back Admin!</h2>
            </div>
            <div class="right-section">
                <form action="adminlogin.jsp" method="post">
                    <div class="form-group">
                        <label for="password">Email</label>
                        <input type="email" id="email" name="email" placeholder="name@gmail.com" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Password</label>
                        <input type="password" id="password" name="password" placeholder="Create a password" required>
                    </div>
                    <button type="submit" class="btn-login">Log In</button>
                </form>
            </div>
        </div>
    </body>
</html>
