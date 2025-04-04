<%--<%@include file="client/navbar.jsp" %>--%>
<%@page import="java.util.List"%>
<%@page session="true" %>
<%
    String email = (String) session.getAttribute("email");
//    String username=(String) session.getAttribute("username");
%>
<%
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    int cartSize = (cart != null) ? cart.size() : 0;
%>
<!-- ======= Header ======= -->
<header id="header" class="fixed-top">
    <div class="container-fluid d-flex">
        <div class="logo mr-auto">
            <h1 class="text-light"><a href="index.jsp"><span>WalkWell</span></a></h1>
        </div>
        <nav class="nav-menu d-none d-lg-block">
            <ul>
                <li><a href="index.jsp" id="hover-link">Home</a></li>
                <li><a href="client/men.jsp" id="hover-link">Mens</a></li>
                <li><a href="client/women.jsp" id="hover-link">Womens</a></li>
                <li class="drop-down"><a href="">Brands</a>
                    <ul>
                        <li><a href="client/adidas.jsp">Adidas</a>
                        </li>
                        <li><a href="client/nike.jsp">Nike</a>
                        </li>
                        <li><a href="client/puma.jsp">Puma</a>
                        </li>
                    </ul>
                </li>
                <li class="drop-down"><a href="">Category</a>
                    <ul>
                        <li><a href="client/sports.jsp">Sports</a>
                        </li>
                        <li><a href="client/casual.jsp">Casual</a>
                        </li>
                        <li><a href="client/sneakers.jsp">Sneakers</a>
                        </li>
                    </ul>
                </li>
                <li><a href="client/contactus.jsp" id="hover-link">Contact us</a></li>
                <li><a href="client/feedback.jsp" id="hover-link">Feedback</a></li>
                <li><a href="client/userInvoices.jsp" id="hover-link">Invoice</a></li>
                <li><a href="client/status.jsp" id="hover-link">Status</a></li>
                <% if (session.getAttribute("email") != null) { %>
                <li class="get-started"><span class="get-started"><a>Welcome, <%= session.getAttribute("email")%>!</a></span></li>
                <li class="get-started"><a href="client/logout.jsp"><i class="fa-solid fa-right-from-bracket"></i></a></li>
                <% } else { %>
                <li class="get-started"><a href="client/login.jsp">Login</a></li>
                <li class="get-started"><a href="client/signup.jsp">Signup</a></li>
                <% } %>
                <% if (session.getAttribute("email") != null) { %>
                <li class="get-started"><a href="client/profile.jsp"><i class="fa-solid fa-user"></i></a></li>
                <% } %>
                <li class="get-started">
                    <% if (session.getAttribute("email") != null) { %>
                    <a href="client/cart.jsp">Cart <i class="fa-solid fa-cart-shopping"></i> (<span id="cart-count"><%= cartSize%></span>)</a>
                    <% } else { %>
                    <a href="client/login.jsp">Cart <i class="fa-solid fa-cart-shopping"></i>(<span id="cart-count"><%= cartSize%></span>)</a>
                    <% }%>
                </li>
            </ul>
        </nav>
    </div>
</header>