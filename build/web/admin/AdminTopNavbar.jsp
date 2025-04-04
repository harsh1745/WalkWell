<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel</title>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/all.min.css">
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <style>
            .navbar {
                position: fixed;
                top:0;
                width: 100%;
                z-index: 1000;
                background-color: #eb5d1e;
            }
            .btn-primary{
                background-color: #eb5d1e !important;
                color: #181C14 !important;
                border: none !important;
            }
        </style>
    </head>
    <body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <a class="navbar-brand" href="#">Admin Panel</a>
        <div class="ml-auto">
            <div class="btn-group">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-user"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item" href="adminlogout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </nav>
    <script src="../js/jquery/jquery.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../fontawesome/js/all.js"></script>