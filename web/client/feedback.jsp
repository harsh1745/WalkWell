<%@ page import="java.sql.*" %>
<%
            if (session == null || session.getAttribute("user_id") == null) {
                response.sendRedirect("login.jsp"); // Redirect to login if not logged in
                return;
            }
            int userId = (Integer) session.getAttribute("user_id");
            String userEmail = (String) session.getAttribute("email");
%>
<%@include file="navbar.jsp" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback - Beauty Care</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../fontawesome/css/all.css">
        <style>
            body {
                background-color: #ECDFCC;
            }
            .feedback-container {
                max-width: 600px;
                margin: 123px auto;
                padding: 20px;
                background: #181C14;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                color: #ECDFCC;
            }
            .feedback-header {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 20px;
                text-align: center;
                color: #eb5d1e;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                font-weight: bold;
                color: #ECDFCC;
            }
            .form-control {
                background-color: #ECDFCC;
                color: #181C14;
                border: 1px solid #eb5d1e;
                border-radius: 4px;
            }
            .form-control:focus {
                border-color: #eb5d1e;
                box-shadow: 0 0 5px rgba(235, 93, 30, 0.5);
            }
            .star-rating {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
                flex-direction: row-reverse;
            }
            .star-rating input {
                display: none;
            }
            .star-rating label {
                font-size: 30px;
                color: #ECDFCC;
                cursor: pointer;
                margin: 0 5px;
                transition: color 0.2s;
            }
            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #eb5d1e;
            }
            .star-rating input:checked + label {
                color: #eb5d1e;
            }
            .btn-primary {
                background-color: #eb5d1e;
                border: none;
                color: #181C14;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            .btn-primary:hover {
                background-color: #d35400;
            }
        </style>
    </head>
    <body>
        <div class="feedback-container">
            <div class="feedback-header">Feedback</div>
            <form action="submitFeedback.jsp" method="POST">
                <input type="hidden" name="user_id" value="<%= userId%>">
                <input type="hidden" name="email" value="<%= userEmail%>">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= userEmail%>" readonly>
                </div>
                <div class="form-group">
                    <label>Rating</label>
                    <div class="star-rating">
                        <!-- Correct order of stars -->
                        <input type="radio" id="star5" name="rating" value="5" required>
                        <label for="star5"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star4" name="rating" value="4">
                        <label for="star4"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star3" name="rating" value="3">
                        <label for="star3"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star2" name="rating" value="2">
                        <label for="star2"><i class="fas fa-star"></i></label>
                        <input type="radio" id="star1" name="rating" value="1">
                        <label for="star1"><i class="fas fa-star"></i></label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="message">Message (Optional)</label>
                    <textarea class="form-control" id="message" name="message" rows="5"></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Submit Feedback</button>
            </form>
        </div>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../fontawesome/js/all.js"></script>
    </body>
</html>