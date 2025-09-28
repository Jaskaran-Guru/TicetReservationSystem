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
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .booking-card {
            background: rgba(255,255,255,0.95);
            border-radius: 16px;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .booking-card:hover {
            transform: translateY(-3px);
        }
        .status-badge {
            border-radius: 20px;
            padding: 6px 12px;
            font-size: 12px;
            font-weight: bold;
        }
        .pnr-badge {
            background: linear-gradient(135deg, #3B82F6, #2563EB);
            color: white;
            border-radius: 12px;
            padding: 8px 16px;
            font-weight: bold;
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
            <a class="nav-link text-dark" href="/dashboard">Dashboard</a>
            <a class="nav-link text-dark" href="/search">Search Trains</a>
            <a class="btn btn-primary" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="text-center mb-4">
                <h2 class="text-white fw-bold">
                    <i class="fas fa-ticket-alt me-3"></i>My Bookings
                </h2>
                <p class="text-light">Manage all your train reservations</p>
            </div>

            <c:choose>
                <c:when test="${not empty bookings}">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card p-4">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="pnr-badge me-3">
                                            PNR: ${booking.pnr}
                                        </div>
                                        <span class="status-badge bg-success">
                                                <i class="fas fa-check-circle me-1"></i>${booking.status}
                                            </span>
                                    </div>

                                    <h5 class="fw-bold text-primary mb-2">
                                        <i class="fas fa-train me-2"></i>${booking.trainName}
                                    </h5>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <p class="mb-2">
                                                <i class="fas fa-route me-2 text-info"></i>
                                                <strong>${booking.source}</strong> → <strong>${booking.destination}</strong>
                                            </p>
                                            <p class="mb-2">
                                                <i class="fas fa-calendar me-2 text-warning"></i>
                                                Journey: ${booking.journeyDate}
                                            </p>
                                        </div>
                                        <div class="col-md-6">
                                            <p class="mb-2">
                                                <i class="fas fa-user me-2 text-success"></i>
                                                Passenger: ${booking.passengerName}
                                            </p>
                                            <p class="mb-2">
                                                <i class="fas fa-chair me-2 text-info"></i>
                                                Class: ${booking.trainClass}
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4 text-end">
                                    <div class="mb-3">
                                        <h4 class="text-success fw-bold mb-1">₹${booking.totalAmount}</h4>
                                        <small class="text-muted">Total Fare</small>
                                    </div>

                                    <div class="btn-group-vertical" role="group">
                                        <button class="btn btn-outline-primary btn-sm mb-2"
                                                onclick="viewDetails('${booking.pnr}')">
                                            <i class="fas fa-eye me-1"></i>View Details
                                        </button>
                                        <button class="btn btn-outline-info btn-sm mb-2"
                                                onclick="downloadTicket('${booking.pnr}')">
                                            <i class="fas fa-download me-1"></i>Download
                                        </button>
                                        <c:if test="${booking.status != 'CANCELLED'}">
                                            <button class="btn btn-outline-danger btn-sm"
                                                    onclick="cancelBooking('${booking.pnr}')">
                                                <i class="fas fa-times me-1"></i>Cancel
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Pagination -->
                    <div class="text-center mt-4">
                        <nav>
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <span class="page-link">Previous</span>
                                </li>
                                <li class="page-item active">
                                    <span class="page-link">1</span>
                                </li>
                                <li class="page-item disabled">
                                    <span class="page-link">Next</span>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="booking-card text-center py-5">
                        <i class="fas fa-ticket-alt fa-5x text-muted mb-4"></i>
                        <h4 class="text-muted mb-3">No Bookings Found</h4>
                        <p class="text-muted mb-4">You haven't made any train reservations yet.</p>
                        <div>
                            <a href="/search" class="btn btn-primary btn-lg me-3">
                                <i class="fas fa-search me-2"></i>Search Trains
                            </a>
                            <a href="/dashboard" class="btn btn-outline-secondary btn-lg">
                                <i class="fas fa-home me-2"></i>Go to Dashboard
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Booking Details Modal -->
<div class="modal fade" id="detailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="fas fa-ticket-alt me-2"></i>Booking Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="bookingDetails">
                    <!-- Booking details will be loaded here -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="printTicket()">
                    <i class="fas fa-print me-2"></i>Print Ticket
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function viewDetails(pnr) {
        // Fetch and show booking details
        document.getElementById('bookingDetails').innerHTML =
            '<div class="text-center"><i class="fas fa-spinner fa-spin"></i> Loading details...</div>';

        const modal = new bootstrap.Modal(document.getElementById('detailsModal'));
        modal.show();

        // Here you would typically make an AJAX call to get booking details
        setTimeout(() => {
            document.getElementById('bookingDetails').innerHTML = `
                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="fw-bold">PNR Number</h6>
                            <p>${pnr}</p>
                            <h6 class="fw-bold">Booking Status</h6>
                            <p><span class="badge bg-success">Confirmed</span></p>
                        </div>
                        <div class="col-md-6">
                            <h6 class="fw-bold">Booking Date</h6>
                            <p>28-09-2025</p>
                            <h6 class="fw-bold">Journey Date</h6>
                            <p>29-09-2025</p>
                        </div>
                    </div>
                `;
        }, 1000);
    }

    function downloadTicket(pnr) {
        alert('Downloading ticket for PNR: ' + pnr);
        // Implement ticket download functionality
    }

    function cancelBooking(pnr) {
        if (confirm('Are you sure you want to cancel this booking?')) {
            window.location.href = '/cancel-booking?pnr=' + pnr;
        }
    }

    function printTicket() {
        window.print();
    }
</script>
</body>
</html>
