<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Feedback</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../DataTable/datatables.min.css">
        <link rel="stylesheet" href="../fontawesome/css/all.css">
        <style>
            body {
                background: linear-gradient(to right, #eb5d1e, #ECDFCC);        }
            .admin-container {
                max-width: 1200px;
                margin: 100px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            .admin-header {
                text-align: center;
                font-weight: 600;
                color: #eb5d1e;
                font-size: 40px;
                margin-bottom: 20px;
            }
            .table-container {
                margin: 75px auto;
                padding: 20px;
                background: #fff;
                border-radius: 12px;
            }
            h1 {
                text-align: center;
                font-weight: 600;
                color: #eb5d1e;
                margin-bottom: 20px;
            }
            table.dataTable {
                border-collapse:inherit;
                border-radius: 8px !important;
                overflow: hidden;
            }
            table.dataTable thead th {
                background-color: #eb5d1e;
                color: #fff;
                font-weight: bold;
                text-transform: uppercase;
                font-size: 14px;
                padding: 12px;
                border-bottom: none !important;
                text-align: center;
            }
            table.dataTable tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s ease;
            }

            table.dataTable tbody tr:hover {
                background-color: #ffd1b8;
            }
            table.dataTable tbody td {
                padding: 15px 10px;
                text-align: center;
                vertical-align: middle;
                font-size: 14px;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button {
                color: #eb5d1e !important;
                border: 1px solid #eb5d1e !important;
                border-radius: 4px;
                padding: 5px 10px;
                margin: 0 3px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                background: #eb5d1e !important;
                color: #fff !important;
                text-decoration: none;
            }
            .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                background: #eb5d1e !important;
                color: #fff !important;
                font-weight: bold;
            }
            .dataTables_wrapper .dataTables_filter input {
                margin-left: 5px;
                border-radius: 20px;
                padding: 5px 10px;
                border: 1px solid #ced4da;
                transition: border-color 0.3s ease;
            }
            .dataTables_wrapper .dataTables_filter input:focus {
                border-color: #eb5d1e;
                outline: none;
            }
            .dataTables_wrapper .dataTables_length select {
                border-radius: 5px;
                padding: 5px 8px;
                border: 1px solid #ced4da;
            }
            .star-rating {
                color: #ffc107;
            }
            .modal-content {
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminTopNavbar.jsp" %>
        <%@include file="AdminSidebar.jsp" %>
        <div class="admin-container">
            <div class="admin-header">Feedback Details</div>
            <table id="feedbackTable" class="display">
                <thead>
                    <tr>
                        <th style="text-align: center;">ID</th>
                        <th>Email</th>
                        <th>Rating</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                                String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                                String dbUser = "root";
                                String dbPassword = "";
                                Connection conn = null;
                                Statement stmt = null;
                                ResultSet rs = null;
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                                    String sql = "SELECT * FROM feedback ORDER BY submission_date DESC";
                                    stmt = conn.createStatement();
                                    rs = stmt.executeQuery(sql);
                                    while (rs.next()) {
                                        int id = rs.getInt("id");
                                        String email = rs.getString("email");
                                        int rating = rs.getInt("rating");
                                        String message = rs.getString("message");
                    %>
                    <tr>
                        <td style="text-align: center;"><%= id%></td>
                        <td>
                            <a href="#" data-toggle="modal" data-target="#feedbackModal<%= id%>">
                                <%= email%>
                            </a>
                        </td>
                        <td>
                            <div class="star-rating">
                                <%
                                                            for (int i = 1; i <= 5; i++) {
                                                                if (i <= rating) {
                                %>
                                <i class="fas fa-star text-warning"></i> <!-- Filled star -->
                                <%                                                                } else {
                                %>
                                <i class="fas fa-star text-secondary"></i> <!-- Empty star -->
                                <%                                                            }
                                                            }
                                %>
                            </div>
                        </td>
                    </tr>
                    <!-- Modal for Feedback Details -->
                <div class="modal fade" id="feedbackModal<%= id%>" tabindex="-1" role="dialog" aria-labelledby="feedbackModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="feedbackModalLabel">Feedback Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p><strong>ID:</strong> <%= id%></p>
                                <p><strong>Email:</strong> <%= email%></p>
                                <p><strong>Rating:</strong>
                                <div class="star-rating">
                                    <% for (int i = 1; i <= 5; i++) {%>
                                    <i class="fas fa-star <%= i <= rating ? "text-warning" : "text-secondary"%>"></i>
                                    <% }%>
                                </div>
                                </p>
                                <p><strong>Message:</strong> <%= message%></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                            } finally {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            }
                %>
                </tbody>
            </table>
        </div>
        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script type="text/javascript" charset="utf8" src="../DataTable/datatables.min.js"></script>
        <script>
            $(document).ready(function() {
                // Initialize DataTable
                $('#feedbackTable').DataTable();
            });
        </script>
    </body>
</html>