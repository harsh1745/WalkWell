package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

public final class dashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(2);
    _jspx_dependants.add("/admin/AdminSidebar.jsp");
    _jspx_dependants.add("/admin/AdminTopNavbar.jsp");
  }

  private org.apache.jasper.runtime.ResourceInjector _jspx_resourceInjector;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.apache.jasper.runtime.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    if (session.getAttribute("email") == null) {
        response.sendRedirect("adminlogin.jsp");
    }

      out.write('\n');
      out.write("<style>\n");
      out.write("    /*    .sidebar {\n");
      out.write("        width: 250px;\n");
      out.write("        height: 100vh;\n");
      out.write("        position: fixed;\n");
      out.write("        background-color: #343a40;\n");
      out.write("        padding-top: 20px;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul {\n");
      out.write("        padding: 0;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li {\n");
      out.write("        list-style: none;\n");
      out.write("        padding: 15px 20px;\n");
      out.write("        transition: all 0.3s ease-in-out;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li a {\n");
      out.write("        color: #fff;\n");
      out.write("        text-decoration: none;\n");
      out.write("        display: flex;\n");
      out.write("        align-items: center;\n");
      out.write("        transition: all 0.3s ease-in-out;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li a i {\n");
      out.write("        margin-right: 10px;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li:hover {\n");
      out.write("        background-color: #495057;\n");
      out.write("        transform: scale(1.05);\n");
      out.write("        border-radius: 4px;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li a:hover {\n");
      out.write("        color: #17a2b8;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .main-content {\n");
      out.write("        margin-left: 250px;\n");
      out.write("        padding: 20px;\n");
      out.write("    }*/\n");
      out.write("    .sidebar {\n");
      out.write("        width: 250px;\n");
      out.write("        height: 100vh;\n");
      out.write("        background-color: #343a40;\n");
      out.write("        color: white;\n");
      out.write("        position: fixed;\n");
      out.write("        margin-top: 55px;\n");
      out.write("        /*padding-top: 57px;*/\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul {\n");
      out.write("        list-style-type: none;\n");
      out.write("        margin: 0;\n");
      out.write("        padding: 0;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li {\n");
      out.write("        padding: 15px 20px;\n");
      out.write("        cursor: pointer;\n");
      out.write("        transition: background-color 0.3s ease;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li:hover {\n");
      out.write("        background-color: #495057;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li a {\n");
      out.write("        text-decoration: none;\n");
      out.write("        color: white;\n");
      out.write("        display: block;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .dropdown {\n");
      out.write("        overflow: hidden;\n");
      out.write("        max-height: 0;\n");
      out.write("        transition: max-height 0.3s ease-in-out;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .dropdown a {\n");
      out.write("        padding-left: 40px;\n");
      out.write("        font-size: 0.9rem;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .sidebar ul li.active + .dropdown {\n");
      out.write("        max-height: 200px; /* Adjust based on dropdown items */\n");
      out.write("    }\n");
      out.write("\n");
      out.write("</style>\n");
      out.write("<div class=\"d-flex\">\n");
      out.write("    <!-- Sidebar -->\n");
      out.write("    <div class=\"sidebar bg-dark text-white\">\n");
      out.write("        <ul class=\"list-unstyled\">\n");
      out.write("            <li><a href=\"dashboard.jsp\" class=\"text-white\"><i class=\"fas fa-tachometer-alt\"></i>&nbsp;&nbsp;Dashboard</a></li>\n");
      out.write("            <li class=\"dropdown-toggle\"><i class=\"fa-solid fa-layer-group\"></i>&nbsp;&nbsp;Brands</li>\n");
      out.write("            <ul class=\"dropdown\">\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-solid fa-shoe-prints\"></i>&nbsp;&nbsp;Nike</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-solid fa-shoe-prints\"></i>&nbsp;&nbsp;Adidas</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-solid fa-shoe-prints\"></i>&nbsp;&nbsp;Puma</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-solid fa-shoe-prints\"></i>&nbsp;&nbsp;Woodland</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-solid fa-shoe-prints\"></i>&nbsp;&nbsp;Skechers</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-solid fa-shoe-prints\"></i>&nbsp;&nbsp;Campus</a></li>\n");
      out.write("\n");
      out.write("            </ul>\n");
      out.write("            <li class=\"dropdown-toggle\"><i class=\"fa-solid fa-layer-group\"></i>&nbsp;&nbsp;Categories</li>\n");
      out.write("            <ul class=\"dropdown\">\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-regular fa-user\"></i>&nbsp;&nbsp;Men</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-regular fa-user\"></i>&nbsp;&nbsp;Women</a></li>\n");
      out.write("                <li><a href=\"#\"><i class=\"fa-regular fa-user\"></i>&nbsp;&nbsp;Kids</a></li>\n");
      out.write("            </ul>\n");
      out.write("            <li class=\"dropdown-toggle\"><i class=\"fa-solid fa-cart-shopping\"></i>&nbsp;&nbsp;Orders</li>\n");
      out.write("            <ul class=\"dropdown\">\n");
      out.write("                <li><a href=\"adminOrders.jsp\"><i class=\"fa-solid fa-chevron-right\"></i>&nbsp;&nbsp;Orders List</a></li>\n");
      out.write("                <li><a href=\"AdminInvoice.jsp\"><i class=\"fa-solid fa-chevron-right\"></i>&nbsp;&nbsp;Invoice</a></li>\n");
      out.write("            </ul>\n");
      out.write("            <li><a href=\"addproducts.jsp\" class=\"text-white\"><i class=\"fa-solid fa-square-plus\"></i>&nbsp;&nbsp;Add Products</a></li>\n");
      out.write("            <li><a href=\"all_products.jsp\" class=\"text-white\"><i class=\"fa-solid fa-bag-shopping\"></i>&nbsp;&nbsp;Products </a></li>\n");
      out.write("            <li><a href=\"adminUsers.jsp\" class=\"text-white\"><i class=\"fas fa-users\"></i>&nbsp;&nbsp;Users</a></li>\n");
      out.write("            <li><a href=\"#\" class=\"text-white\"><i class=\"fa-solid fa-comment-dots\"></i>&nbsp;&nbsp;Reviews</a></li>\n");
      out.write("        </ul>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("<script>\n");
      out.write("    var dropdownToggles = document.querySelectorAll('.dropdown-toggle');\n");
      out.write("    Array.prototype.forEach.call(dropdownToggles, function(item) {\n");
      out.write("        item.addEventListener('click', function() {\n");
      out.write("            // Toggle active class\n");
      out.write("            item.classList.toggle('active');\n");
      out.write("        });\n");
      out.write("    });\n");
      out.write("</script>\n");
      out.write("<!-- Bootstrap 4.6.2 JS and jQuery -->\n");
      out.write("<script src=\"../js/jquery/jquery.min.js\"></script>\n");
      out.write("<script src=\"../js/bootstrap.min.js\"></script>\n");
      out.write("<script src=\"../fontawesome/js/all.js\"></script>");
      out.write('\n');
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("  <meta charset=\"UTF-8\">\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("  <title>Admin Panel</title>\n");
      out.write("  <!-- Bootstrap 4.6.2 CSS -->\n");
      out.write("  <link rel=\"stylesheet\" href=\"../css/bootstrap.min.css\">\n");
      out.write("  <!-- Font Awesome Icons -->\n");
      out.write("  <link rel=\"stylesheet\" href=\"../css/all.min.css\">\n");
      out.write("  <script src=\"../js/bootstrap.min.js\"></script>\n");
      out.write("  <script src=\"../js/jquery/jquery.min.js\"></script>\n");
      out.write("  <script src=\"../js/popper.min.js\"></script>\n");
      out.write("  <style>\n");
      out.write("      .navbar {\n");
      out.write("  position: fixed;\n");
      out.write("  top:0;\n");
      out.write("  width: 100%;\n");
      out.write("  z-index: 1000;\n");
      out.write("}\n");
      out.write("/*body {\n");
      out.write("  padding-top: 56px;  Navbar ki height jitna padding add karein takay content uske niche aaye \n");
      out.write("}*/\n");
      out.write("\n");
      out.write("  </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    \n");
      out.write("<!-- Top Navbar -->\n");
      out.write("  <nav class=\"navbar navbar-expand-lg navbar-dark bg-primary shadow-sm\">\n");
      out.write("    <a class=\"navbar-brand\" href=\"#\">Admin Panel</a>\n");
      out.write("    <div class=\"ml-auto\">\n");
      out.write("      <!--<button class=\"btn btn-primary\"><i class=\"fas fa-bell\"></i></button>-->\n");
      out.write("      <!-- User Icon with Dropdown -->\n");
      out.write("      <div class=\"btn-group\">\n");
      out.write("        <button type=\"button\" class=\"btn btn-primary dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n");
      out.write("          <i class=\"fas fa-user\"></i>\n");
      out.write("        </button>\n");
      out.write("        <div class=\"dropdown-menu dropdown-menu-right\">\n");
      out.write("          <a class=\"dropdown-item\" href=\"#\">Profile</a>\n");
      out.write("          <!--<a class=\"dropdown-item\" href=\"#\">Settings</a>-->\n");
      out.write("          <div class=\"dropdown-divider\"></div>\n");
      out.write("          <a class=\"dropdown-item\" href=\"adminlogout.jsp\">Logout</a>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("  </nav>\n");
      out.write("<!-- Bootstrap 4.6.2 JS and jQuery -->\n");
      out.write("  <script src=\"../js/jquery/jquery.min.js\"></script>\n");
      out.write("  <script src=\"../js/popper.min.js\"></script>\n");
      out.write("  <script src=\"../js/bootstrap.min.js\"></script>\n");
      out.write("  <script src=\"../fontawesome/js/all.js\"></script>");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <title>Admin Panel</title>\n");
      out.write("        <!-- Bootstrap 4.6.2 CSS -->\n");
      out.write("        <link rel=\"stylesheet\" href=\"../css/bootstrap.min.css\">\n");
      out.write("        <!-- Font Awesome Icons -->\n");
      out.write("        <link rel=\"stylesheet\" href=\"../css/all.min.css\">\n");
      out.write("        <style>\n");
      out.write("            /*            body {\n");
      out.write("                            margin: 0;\n");
      out.write("                            font-family: 'Arial', sans-serif;\n");
      out.write("                            background-color: #f8f9fa;\n");
      out.write("                        }\n");
      out.write("                        .navbar {\n");
      out.write("                            position: sticky;\n");
      out.write("                            top: 0;\n");
      out.write("                            z-index: 1000;\n");
      out.write("                        }\n");
      out.write("                        .sidebar {\n");
      out.write("                            width: 250px;\n");
      out.write("                            height: 100vh;\n");
      out.write("                            position: fixed;\n");
      out.write("                            background-color: #343a40;\n");
      out.write("                            padding-top: 20px;\n");
      out.write("                        }\n");
      out.write("                        .sidebar ul {\n");
      out.write("                            padding: 0;\n");
      out.write("                        }\n");
      out.write("                        .sidebar ul li {\n");
      out.write("                            list-style: none;\n");
      out.write("                            padding: 15px 20px;\n");
      out.write("                            transition: all 0.3s ease-in-out;\n");
      out.write("                        }\n");
      out.write("                        .sidebar ul li a {\n");
      out.write("                            color: #fff;\n");
      out.write("                            text-decoration: none;\n");
      out.write("                            display: flex;\n");
      out.write("                            align-items: center;\n");
      out.write("                            transition: all 0.3s ease-in-out;\n");
      out.write("                        }\n");
      out.write("                        .sidebar ul li a i {\n");
      out.write("                            margin-right: 10px;\n");
      out.write("                        }\n");
      out.write("                        .sidebar ul li:hover {\n");
      out.write("                            background-color: #495057;\n");
      out.write("                            transform: scale(1.05);\n");
      out.write("                            border-radius: 4px;\n");
      out.write("                        }\n");
      out.write("                        .sidebar ul li a:hover {\n");
      out.write("                            color: #17a2b8;\n");
      out.write("                        }\n");
      out.write("                        .container-fluid {\n");
      out.write("                            margin-left: 260px;\n");
      out.write("                        }\n");
      out.write("                        .card {\n");
      out.write("                            border: none;\n");
      out.write("                            border-radius: 10px;\n");
      out.write("                            transition: all 0.3s ease-in-out;\n");
      out.write("                        }\n");
      out.write("                        .hover-card:hover {\n");
      out.write("                            transform: scale(1.05);\n");
      out.write("                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);\n");
      out.write("                        }\n");
      out.write("                        .card-body i {\n");
      out.write("                            display: block;\n");
      out.write("                        }*/\n");
      out.write("            .container-fluid {\n");
      out.write("                margin-left: 260px;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("      \n");
      out.write("        <div class=\"d-flex\">\n");
      out.write("            <div class=\"container-fluid p-4\">\n");
      out.write("                <h1 class=\"mb-4\">Dashboard</h1>\n");
      out.write("                <p style=\"margin-top: -20px;\">Whole data about your business here</p>\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <!-- New Orders -->\n");
      out.write("                    ");

                        String jdbcURL = "jdbc:mysql://localhost:3306/walkwell";
                        String dbUser = "root";
                        String dbPassword = "";

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                            // Product count query
                            String sql = "SELECT COUNT(*) AS product_count FROM products";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(sql);

                            int productCount = 0;
                            if (rs.next()) {
                                productCount = rs.getInt("product_count");
                            }

//                            conn.close();
                    
      out.write("\n");
      out.write("                    <div class=\"col-md-3 mb-4\">\n");
      out.write("                        <div class=\"card shadow-sm text-white\" style=\"background-color: #17a2b8;\">\n");
      out.write("                            <div class=\"card-body d-flex align-items-center justify-content-between\">\n");
      out.write("                                <div>\n");
      out.write("                                    <h2 class=\"mb-0\">");
      out.print( productCount);
      out.write("</h2> <!-- Total Products -->\n");
      out.write("                                    <p class=\"mb-0\">All Products</p>\n");
      out.write("                                </div>\n");
      out.write("                                <i class=\"fas fa-box-open fa-2x\"></i> <!-- Product Icon -->\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"card-footer bg-transparent text-white\">\n");
      out.write("                                <a href=\"all_products.jsp\" class=\"text-white text-decoration-none\">\n");
      out.write("                                    More info <i class=\"fas fa-arrow-circle-right\"></i>\n");
      out.write("                                </a>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <!-- Bounce Rate -->\n");
      out.write("                    <div class=\"col-md-3 mb-4\">\n");
      out.write("                        <div class=\"card shadow-sm text-white\" style=\"background-color: #28a745;\">\n");
      out.write("                            <div class=\"card-body d-flex align-items-center justify-content-between\">\n");
      out.write("                                <div>\n");
      out.write("                                    <h2 class=\"mb-0\">53%</h2>\n");
      out.write("                                    <p class=\"mb-0\">Bounce Rate</p>\n");
      out.write("                                </div>\n");
      out.write("                                <i class=\"fas fa-chart-bar fa-2x\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"card-footer bg-transparent text-white\">\n");
      out.write("                                <a href=\"#\" class=\"text-white text-decoration-none\">\n");
      out.write("                                    More info <i class=\"fas fa-arrow-circle-right\"></i>\n");
      out.write("                                </a>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <!-- User Registrations -->\n");
      out.write("                    <div class=\"col-md-3 mb-4\">\n");
      out.write("                        <div class=\"card shadow-sm text-white\" style=\"background-color: #ffc107;\">\n");
      out.write("                            <div class=\"card-body d-flex align-items-center justify-content-between\">\n");
      out.write("                                <div>\n");
      out.write("                                    ");

                    // User count query
                    String userCountQuery = "SELECT COUNT(*) AS user_count FROM users";
                    Statement userStmt = conn.createStatement();
                    ResultSet userRs = userStmt.executeQuery(userCountQuery);

                    int userCount = 0;
                    if (userRs.next()) {
                        userCount = userRs.getInt("user_count");
                    }
                
      out.write("\n");
      out.write("                                    <h2 class=\"mb-0\">");
      out.print( userCount );
      out.write("</h2>\n");
      out.write("                                    <p class=\"mb-0\">User Registrations</p>\n");
      out.write("                                </div>\n");
      out.write("                                <i class=\"fas fa-user-plus fa-2x\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"card-footer bg-transparent text-white\">\n");
      out.write("                                <a href=\"adminUsers.jsp\" class=\"text-white text-decoration-none\">\n");
      out.write("                                    More info <i class=\"fas fa-arrow-circle-right\"></i>\n");
      out.write("                                </a>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <!-- Unique Visitors -->\n");
      out.write("                    <div class=\"col-md-3 mb-4\">\n");
      out.write("                        <div class=\"card shadow-sm text-white\" style=\"background-color: #dc3545;\">\n");
      out.write("                            <div class=\"card-body d-flex align-items-center justify-content-between\">\n");
      out.write("                                <div>\n");
      out.write("                                    <h2 class=\"mb-0\">65</h2>\n");
      out.write("                                    <p class=\"mb-0\">Unique Visitors</p>\n");
      out.write("                                </div>\n");
      out.write("                                <i class=\"fas fa-pie-chart fa-2x\"></i>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"card-footer bg-transparent text-white\">\n");
      out.write("                                <a href=\"#\" class=\"text-white text-decoration-none\">\n");
      out.write("                                    More info <i class=\"fas fa-arrow-circle-right\"></i>\n");
      out.write("                                </a>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                ");

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <!-- Bootstrap 4.6.2 JS and jQuery -->\n");
      out.write("        <script src=\"../js/jquery/jquery.min.js\"></script>\n");
      out.write("        <script src=\"../js/bootstrap.min.js\"></script>\n");
      out.write("        <script src=\"../fontawesome/js/all.js\"></script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
