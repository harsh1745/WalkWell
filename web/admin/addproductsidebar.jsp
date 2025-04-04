<style>
    .sidebar {
        width: 250px;
        height: 100vh;
        background-color: #181C14;
        color: #ECDFCC;
        position: fixed;
    }
    .sidebar ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }
    .sidebar ul li {
        padding: 15px 20px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .sidebar ul li:hover {
        background-color: #eb5d1e;
    }
    .sidebar ul li a {
        text-decoration: none;
        color: #ECDFCC;
        display: block;
    }
    .dropdown {
        overflow: hidden;
        max-height: 0;
        transition: max-height 0.3s ease-in-out;
    }
    .dropdown a {
        padding-left: 40px;
        font-size: 0.9rem;
    }
    .sidebar ul li.active + .dropdown {
        max-height: 200px;
    }
</style>
<div class="d-flex">
    <div class="sidebar text-white">
        <ul class="list-unstyled">
            <li><a href="dashboard.jsp" class="text-white"><i class="fas fa-tachometer-alt"></i>&nbsp;&nbsp;Dashboard</a></li>
            <li class="dropdown-toggle"><i class="fa-solid fa-cart-shopping"></i>&nbsp;&nbsp;Orders</li>
            <ul class="dropdown">
                <li><a href="adminOrders.jsp"><i class="fa-solid fa-chevron-right"></i>&nbsp;&nbsp;Orders List</a></li>
                <li><a href="AdminInvoice.jsp"><i class="fa-solid fa-chevron-right"></i>&nbsp;&nbsp;Invoice</a></li>
            </ul>
            <li><a href="addproducts.jsp" class="text-white"><i class="fa-solid fa-square-plus"></i>&nbsp;&nbsp;Add Products</a></li>
            <li><a href="all_products.jsp" class="text-white"><i class="fa-solid fa-bag-shopping"></i>&nbsp;&nbsp;Products </a></li>
            <li><a href="adminUsers.jsp" class="text-white"><i class="fas fa-users"></i>&nbsp;&nbsp;Users</a></li>
            <li><a href="adminFeedback.jsp" class="text-white"><i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;Reviews</a></li>
            <li><a href="adminContact.jsp" class="text-white"><i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;Contact Details</a></li>
        </ul>
    </div>
</div>
<script>
    var dropdownToggles = document.querySelectorAll('.dropdown-toggle');
    Array.prototype.forEach.call(dropdownToggles, function(item) {
        item.addEventListener('click', function() {
            item.classList.toggle('active');
        });
    });
</script>
<script src="../js/jquery/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../fontawesome/js/all.js"></script>