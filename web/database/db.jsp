<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/walkwell";
    String dbUser = "root";
    String dbPass = ""; // Verify karo ki root user ka password yahi hai
    Connection conn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver"); // Driver Load karo
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass); // Connection banayo
        out.println("Database Connection Successful!");
    } catch (ClassNotFoundException e) {
        out.println("Driver Class Not Found: " + e.getMessage());
    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } finally {
        if (conn != null) conn.close(); // Connection close karo
    }
%>
