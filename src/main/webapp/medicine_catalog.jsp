<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.pharmapro.connectDB.ConnectDB" %>
<%@ page import="com.pharmapro.model.*" %>




<!DOCTYPE html>
<html lang="en">

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
                <a href="about.html" class="nav-item nav-link active"> My Orders</a>
                <a href="about.html" class="nav-item nav-link active">Logout</a>
                
                
            </div>
            <a href="" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">My Cart<i class="fa fa-arrow-right ms-3"></i></a>
        </div>
    </nav>
    <!-- Navbar End -->


    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5" style="background-color: #007bff;">
        <div class="container py-5">
            <h1 class="display-3 text-white mb-3">Medicine Catalog</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">Medicine Catalog</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- Medicine Catalog Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row">
                <!-- //Java code  -->

                <%
                ResultSet rs;
                PreparedStatement ps;
                 User user =new User();
                 String useremail = user.getEmail();
                
                    try {
                        // Get the database connection using the ConnectDB class
                         Connection con=ConnectDB.dbCon();

                        // SQL query to fetch medicine details
                        String query = "SELECT medicine_id, name, manufacturer, price, stock_quantity FROM medicines";
                         ps = con.prepareStatement(query);
                        rs = ps.executeQuery();
                        
                        System.out.println("query fired");

                        // Loop through the result set and display each medicine as a card
                        while (rs.next()) {
                            String name = rs.getString("name");
                            String manufacturer = rs.getString("manufacturer");
                            double price = rs.getDouble("price");
                            int stockQuantity = rs.getInt("stock_quantity");
                %>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="card h-100">
                        <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Medicine Image">
                        <div class="card-body">
                            <h5 class="card-title"><%= name %></h5>
                            <p class="card-text">Manufacturer: <%= manufacturer != null ? manufacturer : "N/A" %></p>
                            <p class="card-text">Price: <%= String.format("%.2f", price) %> INR</p>
                            <p class="card-text">Stock: <%= stockQuantity %></p>
                           
                            <a href="AddToCartServlet?medicine_id=<%= rs.getInt("medicine_id") %>&user_email=<%= useremail %>" class="btn btn-primary">Add to Cart</a>
                            
                        </div>
                    </div>
                </div>
                <%
                   }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } 
                %>

            </div>
        </div>
    </div>
    <!-- Medicine Catalog End -->

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-light mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2024 PharmaPro. All Rights Reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="privacy-policy.html" class="text-light">Privacy Policy</a>
                    <a href="terms.html" class="text-light ms-3">Terms of Use</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>