<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>PharmaPro - Prescription Upload</title>
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
                <a href="service.html" class="nav-item nav-link active">Dashboard</a>
                <a href="about.html" class="nav-item nav-link">My Orders</a>
                <a href="about.html" class="nav-item nav-link">Logout</a>
            </div>
            <a href="" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">My Cart<i class="fa fa-arrow-right ms-3"></i></a>
        </div>
    </nav>
    <!-- Navbar End -->

    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5" style="background-color: #007bff;">
        <div class="container py-5">
            <h1 class="display-3 text-white mb-3">Prescription Upload</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">Prescription Upload</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->

    <!-- Prescription Upload Section Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row">
                <!-- Alert Section -->
                <div id="alertContainer" class="container mt-3">
                    <c:if test="${not empty message}">
                        <div id="alertMessage" class="alert alert-success" role="alert">
                            ${message}
                        </div>
                    </c:if>
                </div>

                <!-- Prescription Card -->
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">
                            <img src="img/prescription-icon.png" alt="prescription" class="img-fluid" style="width: 150px;">
                            <h5 class="my-3">Upload Prescription</h5>
                            <p class="text-muted mb-4">Upload a valid doctor's prescription to purchase the required medicines.</p>
                        </div>
                    </div>
                </div>

                <!-- Upload Prescription Form -->
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <form action="uploadPrescription" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Patient Name</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" name="patientName" placeholder="Enter patient name" required>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Email</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="email" class="form-control" name="email" placeholder="Enter email" required>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Phone Number</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" name="phone" placeholder="Enter phone number" required>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <p class="mb-0">Upload Prescription</p>
                                    </div>
                                    <div class="col-sm-9">
                                        <input type="file" name="prescription_file" accept=".png,.jpg,.pdf" required class="form-control">
                                        <small class="text-muted">Only JPEG, PNG, or PDF files allowed.</small>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <button type="submit" class="btn btn-primary">Upload Prescription</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Prescription Guidelines -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Prescription Guidelines</h5>
                            <ul>
                                <li>Ensure the prescription is valid and signed by a registered doctor.</li>
                                <li>Prescriptions older than 6 months may not be accepted.</li>
                                <li>Make sure all information is clearly visible in the uploaded image or document.</li>
                                <li>In case of any issues, our pharmacist will reach out to you via the provided contact details.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Prescription Upload Section End -->

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

    <!-- Bootstrap JS and Alert Hide Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const alertMessage = document.getElementById("alertMessage");
            if (alertMessage) {
                setTimeout(() => {
                    alertMessage.classList.add("d-none");
                }, 5000); // 5000ms = 5 seconds
            }
        });
    </script>
</body>
</html>
