<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    // Invalidate the session to log out the user
    session.invalidate();
    response.sendRedirect("../index.jsp"); // Redirect to index page after logout
%>
