	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.pharmapro.connectDB.ConnectDB" %>
<%@ page import="com.pharmapro.model.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>PharmaPro - My Cart</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="img/favicon.ico" rel="icon">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700;900&display=swap" rel="stylesheet"> 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">



   <head>
    <meta charset="utf-8">
    <title>PharmaPro</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700;900&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Navbar Start -->
    <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 wow fadeIn" data-wow-delay="0.1s">
        <a href="index.html" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
            <h1 class="m-0 text-primary"><i class="far fa-hospital me-3"></i>PharmaPro</h1>
        </a>
        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto p-4 p-lg-0">
                <a href="index.html" class="nav-item nav-link">Home</a>
                <a href="service.html" class="nav-item nav-link">Profile</a>
                <a href="service.html" class="nav-item nav-link">Dashboard</a>
                
                <a href="about.html" class="nav-item nav-link active">Logout</a>
            </div>
            <a href="" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">My Orders<i class="fa fa-arrow-right ms-3"></i></a>
        </div>
    </nav>
    <!-- Navbar End -->
    
    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5" style="background-color: #007bff;">
        <div class="container py-5">
            <h1 class="display-3 text-white mb-3">Cart</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">Cart</li>
                </ol>
            </nav>
        </div>
    </div>
    
    <!-- Page Header End -->
    
    
    <div class="container-xxl py-5">
        
            <% 
    String cartSuccess = request.getParameter("cartSuccess"); 
    if (cartSuccess != null && cartSuccess.equals("true")) { 
%>
    <script>
        alert("order Confirmed!");
    </script>
<% 
    } 
%>
            
            <!-- Medicine Display -->
            
        <div class="row">
            <%
            String userEmail="itsmyra72@gmail.com";
            HttpSession session1 = request.getSession(false); // Get current session, don't create if it doesn't exist
    		if (session1 != null) {
    		    User user = (User) session1.getAttribute("currentUser");
    		    if (user != null) {
    		        // Use user details
    		        userEmail=user.getEmail();
    		       
    		      
    		    }
    		}
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                 // Use session-based user email in real scenario

                try {
                    con = ConnectDB.dbCon();
                    String query = "SELECT c.quantity, m.medicine_id, m.name, m.manufacturer, m.price, m.stock_quantity " +
                                   "FROM cart c " +
                                   "JOIN medicines m ON c.medicine_id = m.medicine_id " +
                                   "WHERE c.user_email = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, userEmail);  // Set the user email for cart items
                    rs = ps.executeQuery();

                    if (!rs.isBeforeFirst()) {
            %>
                        <p class="text-muted">Your cart is empty.</p>
            <%
                    } else {
                        while (rs.next()) {
                            String name = rs.getString("name");
                            String manufacturer = rs.getString("manufacturer");
                            double price = rs.getDouble("price");
                            int stockQuantity = rs.getInt("stock_quantity");
                            int quantity = rs.getInt("quantity");
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Medicine Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= name %></h5>
                        <p class="card-text">Manufacturer: <%= manufacturer != null ? manufacturer : "N/A" %></p>
                        <p class="card-text">Price: <%= String.format("%.2f", price) %> INR</p>
                        <p class="card-text">Stock: <%= stockQuantity %></p>
                        <p class="card-text">Quantity in Cart: <%= quantity %></p>
                       
                        
                        <a href="OrderServlet?medicine_id=<%= rs.getInt("medicine_id") %>&quantity=<%= quantity %>" class="btn btn-primary">Order Now</a>
                        
                        <a href="RemoveFromCartServlet?medicine_id=<%= rs.getInt("medicine_id") %>" class="btn btn-danger">Remove</a>
                        
                    </div>
                </div>
            </div>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
    <!-- Medicine Catalog End -->

    <!-- Footer Start -->
    <!-- ... (existing footer code) ... -->
    <!-- Footer End -->

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
	