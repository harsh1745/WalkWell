<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #181C14; /* Updated background color */
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
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
            .forgot-password-container {
                max-width: 400px;
                width: 100%;
                padding: 20px;
                background: #ECDFCC;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .forgot-password-container h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #181C14; /* Updated heading color */
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-size: 14px;
                color: #181C14; /* Updated label color */
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
            .btn-submit {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                background-color: #eb5d1e; /* Updated button background color */
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease; /* Smooth hover effect */
            }
            .btn-submit:hover {
                background-color: #d04a0e; /* Darker shade for hover effect */
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
                background-color: #eb5d1e; /* Updated popup background color */
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.5s ease, visibility 0.5s ease, transform 0.5s ease;
                box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
            }
            .popup-message.show {
                opacity: 1;
                visibility: visible;
                transform: translateX(-50%) scale(1);
                animation: bounceIn 0.5s ease;
            }
            @keyframes bounceIn {
                0% { transform: translateX(-50%) scale(0.8); opacity: 0; }
            50% { transform: translateX(-50%) scale(1.1); opacity: 1; }
            100% { transform: translateX(-50%) scale(1); opacity: 1; }
            }
        </style>
    </head>
    <body>
        <div class="forgot-password-container">
            <h2>Forgot Password</h2>
            <form action="sendResetLink.jsp" method="post">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <button type="submit" class="btn-submit">Submit</button>
                <a href="login.jsp" class="forgot-pass">Back To Login</a>
            </form>
        </div>
        <%
                    String popupClass = "";
                    String popupMessage = "";
                    if (request.getParameter("error") != null) {
                        popupClass = "popup-error";
                        popupMessage = request.getParameter("error");
                    } else if (request.getParameter("success") != null) {
                        popupClass = "popup-success";
                        popupMessage = request.getParameter("success");
                    }
        %>
        <div class="popup-message <%= popupClass%> <%= popupClass.isEmpty() ? "" : "show"%>">
            <%= popupMessage%>
        </div>
        <script>
            var popupMessage = document.querySelector('.popup-message');
            if (popupMessage) {
                setTimeout(function() {
                    popupMessage.classList.remove('show');
                }, 3000);
            }
        </script>
    </body>
</html>