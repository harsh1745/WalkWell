<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("user_id");
    String userEmail = (String) session.getAttribute("email");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="navbar.jsp" %>
<%@include file="header.jsp" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Beauty Care</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../fontawesome/css/all.css" rel="stylesheet">

    <style>
    body {
        background-color: #ECDFCC;
    }
    .contact-container {
        max-width: 600px;
        margin: 100px auto;
        padding: 20px;
        background: #181C14;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        color: #ECDFCC;
    }
    .contact-header {
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
    <div class="contact-container">
        <div class="contact-header">Contact Us</div>
        <form action="submitContact.jsp" method="POST">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="message">Message</label>
                <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Submit</button>
        </form>
    </div>
    <!-- Bootstrap JS -->
    <script src="../js/bootstrap.min.js"></script>
    <script src="../fontawesome/js/all.js"></script>
</body>
</html>