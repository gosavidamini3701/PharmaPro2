<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.pharmapro.connectDB.ConnectDB" %>
<%@ page import="com.pharmapro.model.*" %>
<%@ page import="java.util.UUID" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>PharmaPro - Order Confirmation </title>
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

<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #11598d;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            color: #11598d;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #11598d;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .submit-button:hover {
            background-color: #45a049;
        }
    </style>
    <!-- Navbar Start -->
   
    <!-- Navbar End -->
    
    <!-- Page Header Start -->
   
    
    <!-- Page Header End -->
    
    
    
 
           <div class="container-xxl py-5">
        <div class="container">
            <!-- Medicine Display -->
            <div class="row">
                <%
                String userName="";
                session = request.getSession(false); // 'false' prevents creating a new session if one doesn't exist
                if (session != null) {
                    User user = (User) session.getAttribute("user");
                    if (user != null) {
                    	userName = user.getUserName();
                        
                    } 
                } 
                   
                
                
			    // Retrieve parameters
			    String medicineManufacturer="null";
			    String expiry_date="null";
			    String address = request.getParameter("address");
			    String paymentMethod = request.getParameter("paymentMethod");
			
			    // Check if address or payment method is missing
			    if (address == null || address.isEmpty() || paymentMethod == null || paymentMethod.isEmpty()) {
			        // Redirect to another page if information is missing
			        response.sendRedirect("order_details_form.jsp");
			        return;
			    }
			

			             int quatity= Integer.parseInt(request.getParameter("quantity"));
			             

					    String medicineId = request.getParameter("medicineId");
					    String quantity = request.getParameter("quantity");
					    
					
					    // Initialize variables for medicine details
					    String medicineName = "";
					    String medicineDescription = "";
					    double medicinePrice = 0.0;
					
					    // Use ConnectDB to get the database connection
					    Connection conn = null;
					    PreparedStatement stmt = null;
					    ResultSet rs = null;
					
					    try {
					        conn = ConnectDB.dbCon();  // Establish connection using ConnectDB
					
					        // Prepare SQL query to retrieve medicine details using medicineId
					        String sql = "SELECT name, manufacturer,expiry_date,price FROM medicines WHERE medicine_id = ?";
					        stmt = conn.prepareStatement(sql);
					        stmt.setString(1, medicineId);
					
					        // Execute query
					        rs = stmt.executeQuery();
					
					        // Extract data from result set
					        if (rs.next()) {
					            medicineName = rs.getString("name");
					            medicineManufacturer = rs.getString("manufacturer");
					            expiry_date= rs.getString("expiry_date");
					            medicinePrice = rs.getDouble("price");
					        }
					    } catch (Exception e) {
					        e.printStackTrace();
					    } 
					    
					    double total=medicinePrice*quatity;
					%>
                <div class="col-lg-6 col-md-8 col-sm-12 mb-8">
                    <div class="card h-400">
                        
                        <div class="card-body">
                            <h1>Thank You for Your Order!</h1>
                            <p> Your order has been placed successfully.</p>
                            
                            <p><span class="card-text">Name :</span> <%= userName %></p>
                            
                            <p><span class="card-text">Order Number:</span> #<%= UUID.randomUUID().toString() %></p>

                            <p><span class="card-text">Medicine Name:</span> <%= medicineName %></p>

                            <p><span class="card-text">Quantity:</span> <%= request.getParameter("quantity") %></p>

                            <p><span class="card-text">Medicine Manufacturer :</span> <%= medicineManufacturer %></p>

                             <p><span class="card-text">Price :</span> <%= medicinePrice %></p>

                            <p><span class="card-text">Medicine Expiry date</span> <%= expiry_date %></p>

                            <p><span class="card-text">Delivery Address:</span> <%= address %></p>
                            <p><span class="card-text">Payment Method:</span> <%= paymentMethod %></p>
                            
                            <p><span class="card-text">Total Amount:</span> <%= total%></p>

                           <a href="generateReceipt?orderNumber=<%= UUID.randomUUID().toString() %>&medicineName=<%= medicineName %>&quantity=<%= request.getParameter("quantity") %>&manufacturer=<%= medicineManufacturer %>&expiryDate=<%= expiry_date %>&address=<%= address %>&paymentMethod=<%= paymentMethod %>" class="btn btn-primary">Get the Receipt</a>
                             <a href="dashboard.html" class="btn btn-primary">Continue Shopping</a>
                        </div>
                         
                    </div>
                </div>
                
      </div>
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
