<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Signup</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                border: 2px solid #181C14;
                border: 2px solid white;
                padding: 10px 20px;
                text-transform: uppercase;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
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
                border-radius: 8px;
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
                background-color: #181C14; /* Dark background */
                color: #ECDFCC; /* Light beige text */
            }

            .forgot-pass {
                display: block;
                text-align: center;
                margin-top: 10px;
                font-size: 12px;
                color: #181C14; /* Dark text */
            }

            .forgot-pass:hover {
                color: #eb5d1e; /* Orange hover */
            }
            /* Popup styles */
            .popup-message {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%) scale(0.8); /* Initial scale for animation */
                padding: 15px 30px;
                z-index: 1000;
                color: #fff;
                font-weight: bold;
                border-radius: 10px;
                background-color: #eb5d1e; /* Orange background */
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.5s ease, visibility 0.5s ease, transform 0.5s ease;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            }

            /* Success message */
            .popup-success {
                background-color: #4CAF50; /* Green for success */
            }

            /* Error message */
            .popup-error {
                background-color: #f44336; /* Red for error */
            }

            /* Show the popup */
            .popup-message.show {
                opacity: 1;
                visibility: visible;
                transform: translateX(-50%) scale(1); /* Scale to full size */
                animation: bounceIn 0.5s ease; /* Add bounce effect */
            }

            /* Keyframes for bounce effect */
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
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneno = request.getParameter("phone");
            String address = request.getParameter("address");

            String maskedPhone = "";

            if (phoneno != null && phoneno.length() > 4) {
                int length = phoneno.length();
                String lastFourDigits = phoneno.substring(length - 4);

                StringBuilder maskedPart = new StringBuilder();
                for (int i = 0; i < length - 4; i++) {
                    maskedPart.append("*");
                }
                maskedPhone = maskedPart.toString() + lastFourDigits;
            }

            if (username != null && email != null && password != null && phoneno != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    MessageDigest md = MessageDigest.getInstance("SHA-256");
                    byte[] hash = md.digest(password.getBytes("UTF-8"));
                    StringBuilder hexString = new StringBuilder();
                    for (byte b : hash) {
                        String hex = Integer.toHexString(0xff & b);
                        if (hex.length() == 1) {
                            hexString.append('0');
                        }
                        hexString.append(hex);
                    }
                    String hashedPassword = hexString.toString();

                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
                    String query = "INSERT INTO users (username, email, password, phone,address) VALUES (?, ?, ?, ?,?)";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, username);
                    pstmt.setString(2, email);
                    pstmt.setString(3, hashedPassword);
                    pstmt.setString(4, maskedPhone);
                    pstmt.setString(5, address);

                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        popupClass = "popup-success";
                        popupMessage = "Signup successful! Redirecting to login page...";
                        response.setHeader("Refresh", "3; URL=login.jsp");
                    } else {
                        popupClass = "popup-error";
                        popupMessage = "Signup failed. Try again!";
                    }
                } catch (Exception e) {
                    popupClass = "popup-error";
                    popupMessage = "Error: " + e.getMessage();
                } finally {
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
        <div class="login-container">
            <!-- Left Section -->
            <div class="left-section">
                <h2>New to our Shoe Collection?</h2>
                <p>Discover the latest trends and innovations in footwear. From casual sneakers to elegant formal shoes, we have something for every occasion.</p>
                <button class="btn-create-account"><a href="login.jsp">Login</a></button>
            </div>
            <!-- Right Section -->
            <div class="right-section">
                <h2>Welcome Back!</h2>
                <p>Please Signup now</p>
                <form action="signup.jsp" method="post">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Email</label>
                        <input type="email" id="email" name="email" placeholder="name@gmail.com" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Password</label>
                        <input type="password" id="password" name="password" placeholder="Create a password" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" placeholder="Enter your address" required>
                    </div>
                    <button type="submit" class="btn-login">Register</button>
                    <!--<a href="#" class="forgot-pass">Forgot Password?</a>-->
                </form>
            </div>
        </div>

        <script>
            const popupMessage = document.querySelector('.popup-message');
            if (popupMessage) {
                setTimeout(function() {  // Regular function ka use karo
                    popupMessage.classList.remove('show');
                }, 3000);
            }
        </script>
    </body>
</html>
