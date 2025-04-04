<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
                background: linear-gradient(135deg, #ECDFCC, #eb5d1e); /* Gradient with beige and orange */
                color: #181C14; /* Dark text */
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
                color: #181C14; /* Dark text */
/*                border: 2px solid #181C14;  Dark border */
/*                border: 2px solid white;*/
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
                background-color: #181C14; /* Dark background */
                color: #ECDFCC; /* Light beige text */
                border: 2px solid #ECDFCC;
            }

            .right-section h2 {
                margin-bottom: 10px;
                font-size: 24px;
                font-weight: bold;
                text-align: center;
                color: #181C14; /* Dark text */
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
                color: #181C14; /* Dark text */
            }

            .form-group input {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                 border: 1px solid #181C14; /* Dark border */
                border-radius: 8px;
                background-color: #ECDFCC; /* Light beige background */
                color: #181C14; /* Dark text */
            }

            .form-group input[type="checkbox"] {
                width: auto;
                margin-right: 5px;
            }

            .btn-login {
                background-color: transparent;
               color: #181C14; /* Dark text */
                border: 2px solid #181C14; /* Dark border */
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
                            // Hash the password
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

                            // Load MySQL driver
                            Class.forName("com.mysql.jdbc.Driver"); // Use "com.mysql.cj.jdbc.Driver" for MySQL Connector/J 8.x

                            // Establish connection
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");

                            // Prepare SQL query
                            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
                            pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, email);
                            pstmt.setString(2, hashedPassword);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                session.setAttribute("email", email);
                                session.setAttribute("user_id", rs.getInt("user_id"));

                                // Fetch cart data from the database
                                List<Integer> cart = new ArrayList<Integer>();
                                try {
                                    Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
                                    String query2 = "SELECT product_id FROM user_cart WHERE user_id = ?";
                                    PreparedStatement pstmt2 = conn2.prepareStatement(query2);
                                    pstmt2.setInt(1, rs.getInt("user_id"));
                                    ResultSet rs2 = pstmt2.executeQuery();

                                    while (rs2.next()) {
                                        cart.add(rs2.getInt("product_id"));
                                    }
                                    session.setAttribute("cart", cart);
                                    conn2.close();
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                }

                                popupClass = "popup-success";
                                popupMessage = "Login successful! Redirecting to Home Page...";
                                response.setHeader("Refresh", "3; URL=../index.jsp");
                            } else {
                                popupClass = "popup-error";
                                popupMessage = "Invalid username or password!";
                            }
                        } catch (Exception e) {
                            popupClass = "popup-error";
                            popupMessage = "Error: " + e.getMessage();
                        } finally {
                            // Close resources
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
            const popupMessage = document.querySelector('.popup-message');
            if (popupMessage) {
                setTimeout(function() {  // Regular function ka use karo
                    popupMessage.classList.remove('show');
                }, 3000);
            }
        </script>

        <!--<div class="header">Login</div>-->

        <div class="login-container">
            <!-- Left Section -->
            <div class="left-section">
                <h2>New to our Shoe Collection?</h2>
                <p>Discover the latest trends and innovations in footwear. From casual sneakers to elegant formal shoes, we have something for every occasion.</p>
                <button class="btn-create-account"><a href="signup.jsp">Create an Account</a></button>
            </div>

            <!-- Right Section -->
            <div class="right-section">
                <h2>Welcome Back!</h2>
                <p>Please Signin now</p>
                <form action="login.jsp" method="post">
                    <div class="form-group">
                        <label for="password">Email</label>
                        <input type="email" id="email" name="email" placeholder="name@gmail.com" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Password</label>
                        <input type="password" id="password" name="password" placeholder="Create a password" required>
                    </div>
                    <button type="submit" class="btn-login">Log In</button>
                    <a href="forgotPassword.jsp" class="forgot-pass">Forgot Password?</a>
                </form>
            </div>
        </div>

    </body>
</html>
