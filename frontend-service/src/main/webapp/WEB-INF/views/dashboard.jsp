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
            padding-top: 76px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .dashboard-card {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            backdrop-filter: blur(15px);
        }
        .stat-card {
            background: linear-gradient(135deg, #3B82F6, #2563EB);
            color: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            text-align: center;
        }
        .quick-action-btn {
            border-radius: 12px;
            padding: 15px 25px;
            margin: 0.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .welcome-text {
            background: linear-gradient(135deg, #3B82F6, #1D4ED8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold fs-3 text-primary" href="/">
            <i class="fas fa-train me-2"></i>WaygonWay
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-dark fw-medium me-3" href="/search">Search Trains</a>
            <a class="nav-link text-dark fw-medium me-3" href="/my-bookings">My Bookings</a>
            <a class="nav-link text-dark fw-medium me-3" href="/pnr-status">PNR Status</a>
            <div class="dropdown">
                <a class="nav-link dropdown-toggle text-dark fw-medium" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user-circle me-1"></i>${user.firstName}
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="/profile"><i class="fas fa-user me-2"></i>Profile</a></li>
                    <li><a class="dropdown-item" href="/settings"><i class="fas fa-cog me-2"></i>Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <!-- Welcome Section -->
    <div class="dashboard-card">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="welcome-text fw-bold">
                    <i class="fas fa-hand-wave me-2"></i>Welcome back, ${user.firstName}!
                </h2>
                <p class="text-muted fs-5 mb-0">Ready to plan your next journey?</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="/search" class="btn btn-primary quick-action-btn">
                    <i class="fas fa-search me-2"></i>Book New Ticket
                </a>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Stats Cards -->
        <div class="col-md-4">
            <div class="stat-card">
                <i class="fas fa-ticket-alt fa-3x mb-3"></i>
                <h3>${bookingCount}</h3>
                <p class="mb-0">Total Bookings</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <i class="fas fa-route fa-3x mb-3"></i>
                <h3>15+</h3>
                <p class="mb-0">Routes Available</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <i class="fas fa-train fa-3x mb-3"></i>
                <h3>100+</h3>
                <p class="mb-0">Trains Listed</p>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="dashboard-card">
        <h4 class="fw-bold mb-4">
            <i class="fas fa-bolt text-primary me-2"></i>Quick Actions
        </h4>
        <div class="row">
            <div class="col-md-3 text-center">
                <a href="/search" class="btn btn-outline-primary w-100 mb-3">
                    <i class="fas fa-search fa-2x d-block mb-2"></i>
                    Search Trains
                </a>
            </div>
            <div class="col-md-3 text-center">
                <a href="/my-bookings" class="btn btn-outline-success w-100 mb-3">
                    <i class="fas fa-list fa-2x d-block mb-2"></i>
                    My Bookings
                </a>
            </div>
            <div class="col-md-3 text-center">
                <a href="/pnr-status" class="btn btn-outline-info w-100 mb-3">
                    <i class="fas fa-info-circle fa-2x d-block mb-2"></i>
                    Check PNR
                </a>
            </div>
            <div class="col-md-3 text-center">
                <a href="/profile" class="btn btn-outline-warning w-100 mb-3">
                    <i class="fas fa-user fa-2x d-block mb-2"></i>
                    Profile
                </a>
            </div>
        </div>
    </div>

    <!-- Recent Bookings -->
    <div class="dashboard-card">
        <h4 class="fw-bold mb-4">
            <i class="fas fa-history text-primary me-2"></i>Recent Bookings
        </h4>
        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-primary">
                        <tr>
                            <th>PNR</th>
                            <th>Train</th>
                            <th>Route</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="booking" items="${bookings}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <tr>
                                    <td><strong>${booking.pnr}</strong></td>
                                    <td>${booking.trainName}</td>
                                    <td>${booking.source} → ${booking.destination}</td>
                                    <td>${booking.journeyDate}</td>
                                    <td><span class="badge bg-success">${booking.status}</span></td>
                                    <td>
                                        <a href="/booking-details/${booking.pnr}" class="btn btn-sm btn-outline-primary">
                                            View Details
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="text-center">
                    <a href="/my-bookings" class="btn btn-primary">View All Bookings</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="fas fa-ticket-alt fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No bookings yet</h5>
                    <p class="text-muted">Start booking your first train ticket!</p>
                    <a href="/search" class="btn btn-primary">Search Trains</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
