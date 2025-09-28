<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4F46E5 0%, #3B82F6 25%, #2563EB 50%, #1D4ED8 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
        .hero-section {
            padding: 120px 0;
            text-align: center;
            color: white;
        }
        .search-card {
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 2.5rem;
            margin-top: 2rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            backdrop-filter: blur(15px);
        }
        .form-control, .form-select {
            border-radius: 12px;
            padding: 12px 20px;
            border: 2px solid #e2e8f0;
            font-size: 16px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #3B82F6;
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }
        .btn-search {
            background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%);
            border: none;
            border-radius: 12px;
            padding: 15px 30px;
            font-size: 18px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
        }
        .floating-shapes {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }
        .shape {
            position: absolute;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }
        .shape:nth-child(1) { width: 80px; height: 80px; top: 20%; left: 10%; animation-delay: 0s; }
        .shape:nth-child(2) { width: 120px; height: 120px; top: 60%; left: 80%; animation-delay: 1s; }
        .shape:nth-child(3) { width: 60px; height: 60px; top: 80%; left: 20%; animation-delay: 2s; }
        .shape:nth-child(4) { width: 100px; height: 100px; top: 30%; left: 70%; animation-delay: 3s; }
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }
    </style>
</head>
<body>
<div class="floating-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold fs-3 text-primary" href="/">
            <i class="fas fa-train me-2"></i>WaygonWay
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link text-dark fw-medium" href="/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark fw-medium" href="/search">Search Trains</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark fw-medium" href="/pnr-status">PNR Status</a>
                </li>
            </ul>
            <div class="d-flex">
                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <a class="nav-link text-dark fw-medium me-3" href="/dashboard">Dashboard</a>
                        <a class="nav-link text-dark fw-medium me-3" href="/my-bookings">My Bookings</a>
                        <a class="btn btn-outline-danger" href="/logout">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-outline-primary me-2" href="/login">Login</a>
                        <a class="btn btn-warning text-dark fw-bold" href="/register">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <h1 class="display-3 fw-bold mb-4">
            Book Your Journey with Confidence
        </h1>
        <p class="lead fs-4 mb-5">
            Experience seamless railway booking with India's most trusted platform. Fast, secure, and reliable - your perfect travel companion.
        </p>

        <!-- Search Form -->
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="search-card">
                    <h3 class="text-dark mb-4 fw-bold">
                        <i class="fas fa-search text-primary me-2"></i>Find Your Perfect Train
                    </h3>
                    <form action="/search" method="post">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="source" name="source" placeholder="From Station" required>
                                    <label for="source"><i class="fas fa-map-marker-alt text-primary me-2"></i>From Station</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="destination" name="destination" placeholder="To Station" required>
                                    <label for="destination"><i class="fas fa-map-marker-alt text-success me-2"></i>To Station</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <input type="date" class="form-control" id="travelDate" name="travelDate" required>
                                    <label for="travelDate"><i class="fas fa-calendar text-info me-2"></i>Journey Date</label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-floating">
                                    <select class="form-select" id="trainClass" name="trainClass">
                                        <option value="">All Classes</option>
                                        <option value="SL">Sleeper (SL)</option>
                                        <option value="3A">AC 3 Tier (3A)</option>
                                        <option value="2A">AC 2 Tier (2A)</option>
                                        <option value="1A">AC First Class (1A)</option>
                                    </select>
                                    <label for="trainClass"><i class="fas fa-train text-warning me-2"></i>Travel Class</label>
                                </div>
                            </div>
                            <div class="col-12 mt-4">
                                <button type="submit" class="btn btn-primary btn-search btn-lg w-100">
                                    <i class="fas fa-search me-2"></i>SEARCH TRAINS
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set minimum date to today
    document.getElementById('travelDate').min = new Date().toISOString().split('T')[0];
</script>
</body>
</html>
