<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - All Users</title>
        <link rel="stylesheet" href="../DataTable/datatables.min.css">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <style>
            body {
                background: linear-gradient(to right, #eb5d1e, #ECDFCC);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
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
                text-align: center; /* Center align headers */
            }

            table.dataTable tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s ease;
            }

            table.dataTable tbody tr:hover {
                background-color: #ffd1b8; /* Light orange hover effect */
            }

            table.dataTable tbody td {
                padding: 15px 10px;
                text-align: center; /* Center align content */
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
            .modal-content {
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="AdminTopNavbar.jsp" %>
        <%@include file="AdminSidebar.jsp" %>
        <div class="container table-container">
            <h1>All Users</h1>
            <table id="usersTable" class="display">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/walkwell", "root", "");
                            String query = "SELECT username, email, phone, address, created_at FROM users";
                            pstmt = conn.prepareStatement(query);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String username = rs.getString("username");
                                String email = rs.getString("email");
                                String phone = rs.getString("phone");
                                String address = rs.getString("address");
                                String createdAt = rs.getString("created_at");
                    %>
                    <tr>
                        <td><%= username%></td>
                        <td><a href="#" data-toggle="modal" data-target="#userModal" 
                               data-username="<%= username%>" 
                               data-email="<%= email%>" 
                               data-phone="<%= phone%>" 
                               data-address="<%= address%>" 
                               data-created-at="<%= createdAt%>">
                                <%= email%>
                            </a></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
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
                    %>
                </tbody>
            </table>
        </div>

        <!-- User Profile Modal -->
        <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="userModalLabel">User Profile</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Username:</strong> <span id="modalUsername"></span></p>
                        <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                        <p><strong>Phone:</strong> <span id="modalPhone"></span></p>
                        <p><strong>Address:</strong> <span id="modalAddress"></span></p>
                        <p><strong>Created At:</strong> <span id="modalCreatedAt"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="../js/jquery/jquery.min.js"></script>
        <script src="../DataTable/datatables.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script>
            $(document).ready(function () {
                // Initialize DataTable
                $('#usersTable').DataTable();

                // Handle modal data
                $('#userModal').on('show.bs.modal', function (event) {
                    var link = $(event.relatedTarget); // Link that triggered the modal
                    var username = link.data('username');
                    var email = link.data('email');
                    var phone = link.data('phone');
                    var address = link.data('address');
                    var createdAt = link.data('created-at');

                    // Update modal content
                    $('#modalUsername').text(username);
                    $('#modalEmail').text(email);
                    $('#modalPhone').text(phone);
                    $('#modalAddress').text(address);
                    $('#modalCreatedAt').text(createdAt);
                });
            });
        </script>
    </body>
</html>