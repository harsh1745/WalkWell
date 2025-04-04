<%@ page session="true" %>
<%
    session.invalidate();
    response.sendRedirect("adminlogin.jsp"); // Redirect to login page
%>
