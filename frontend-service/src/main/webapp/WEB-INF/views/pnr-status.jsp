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
        .pnr-card {
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            backdrop-filter: blur(15px);
        }
        .form-control {
            border-radius: 16px;
            border: 2px solid #e2e8f0;
            padding: 15px 20px;
            font-size: 18px;
            text-align: center;
            font-weight: bold;
            letter-spacing: 2px;
        }
        .form-control:focus {
            border-color: #3B82F6;
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }
        .btn-check {
            background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%);
            border: none;
            border-radius: 16px;
            padding: 15px 40px;
            font-weight: 600;
            text-transform: uppercase;
        }
        .status-card {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 2rem;
            margin-top: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .status-confirmed { border-left: 5px solid #10b981; }
        .status-waitlist { border-left: 5px solid #f59e0b; }
        .status-cancelled { border-left: 5px solid #ef4444; }
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
            <a class="nav-link text-dark" href="/">Home</a>
            <a class="nav-link text-dark" href="/search">Search</a>
            <c:if test="${isLoggedIn}">
                <a class="nav-link text-dark" href="/dashboard">Dashboard</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="text-center mb-4">
                <h1 class="text-white fw-bold display-4 mb-3">
                    <i class="fas fa-search-plus me-3"></i>PNR Status
                </h1>
                <p class="text-light fs-5">Check your booking status instantly</p>
            </div>

            <div class="pnr-card">
                <div class="text-center mb-4">
                    <i class="fas fa-ticket-alt fa-4x text-primary mb-3"></i>
                    <h3 class="fw-bold text-primary">Enter PNR Number</h3>
                    <p class="text-muted">Enter your 10-digit PNR number to check status</p>
                </div>

                <form action="/pnr-status" method="post">
                    <div class="mb-4">
                        <input type="text" class="form-control form-control-lg" name="pnr"
                               placeholder="Enter PNR Number" maxlength="10" pattern="[0-9]{10}"
                               value="${searchedPNR}" required>
                        <div class="form-text text-center mt-2">
                            <i class="fas fa-info-circle me-1"></i>PNR number is a 10-digit number
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-check w-100 btn-lg">
                        <i class="fas fa-search me-2"></i>Check Status
                    </button>
                </form>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger mt-4">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>
            </div>

            <!-- PNR Status Result -->
            <c:if test="${pnrFound == true}">
                <div class="status-card status-confirmed">
                    <div class="row align-items-center mb-4">
                        <div class="col-md-8">
                            <h4 class="fw-bold text-success mb-2">
                                <i class="fas fa-check-circle me-2"></i>Booking Confirmed
                            </h4>
                            <p class="text-muted mb-0">PNR: <strong>${searchedPNR}</strong></p>
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="badge bg-success fs-6 px-3 py-2">CONFIRMED</span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <h6 class="fw-bold text-primary mb-2">Train Details</h6>
                                <p class="mb-1"><i class="fas fa-train me-2"></i><strong>${booking.trainName}</strong></p>
                                <p class="mb-1"><i class="fas fa-hashtag me-2"></i>Train No: ${booking.trainCode}</p>
                                <p class="mb-0"><i class="fas fa-route me-2"></i>${booking.source} → ${booking.destination}</p>
                            </div>

                            <div class="mb-3">
                                <h6 class="fw-bold text-primary mb-2">Journey Details</h6>
                                <p class="mb-1"><i class="fas fa-calendar me-2"></i>Date: ${booking.journeyDate}</p>
                                <p class="mb-1"><i class="fas fa-clock me-2"></i>Departure: 08:00 AM</p>
                                <p class="mb-0"><i class="fas fa-map-marker-alt me-2"></i>Platform: TBD</p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-3">
                                <h6 class="fw-bold text-primary mb-2">Passenger Details</h6>
                                <p class="mb-1"><i class="fas fa-user me-2"></i>Name: ${booking.passengerName}</p>
                                <p class="mb-1"><i class="fas fa-id-card me-2"></i>Age: ${booking.passengerAge}</p>
                                <p class="mb-0"><i class="fas fa-venus-mars me-2"></i>Gender: ${booking.passengerGender}</p>
                            </div>

                            <div class="mb-3">
                                <h6 class="fw-bold text-primary mb-2">Seat Details</h6>
                                <p class="mb-1"><i class="fas fa-chair me-2"></i>Class: ${booking.trainClass}</p>
                                <p class="mb-1"><i class="fas fa-credit-card me-2"></i>Fare: ₹${booking.totalAmount}</p>
                                <p class="mb-0"><i class="fas fa-bed me-2"></i>Seat: S4/42 (Confirmed)</p>
                            </div>
                        </div>
                    </div>

                    <div class="border-top pt-3">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="text-muted mb-0">
                                    <i class="fas fa-calendar-check me-2"></i>Booking Date: ${booking.bookingDate}
                                </p>
                            </div>
                            <div class="col-md-6 text-end">
                                <button class="btn btn-outline-primary btn-sm me-2" onclick="printTicket()">
                                    <i class="fas fa-print me-1"></i>Print
                                </button>
                                <button class="btn btn-outline-info btn-sm" onclick="downloadTicket()">
                                    <i class="fas fa-download me-1"></i>Download
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${pnrFound == false && not empty searchedPNR}">
                <div class="status-card status-cancelled">
                    <div class="text-center py-4">
                        <i class="fas fa-times-circle fa-4x text-danger mb-3"></i>
                        <h4 class="fw-bold text-danger mb-3">PNR Not Found</h4>
                        <p class="text-muted mb-4">
                            No booking found with PNR: <strong>${searchedPNR}</strong>
                        </p>

                        <div class="alert alert-info">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-info-circle me-2"></i>Please check:
                            </h6>
                            <ul class="list-unstyled mb-0">
                                <li class="mb-1">• PNR number is entered correctly</li>
                                <li class="mb-1">• Booking was made through WaygonWay</li>
                                <li class="mb-1">• PNR is not older than 4 months</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Sample PNR Info -->
            <div class="pnr-card mt-4">
                <h5 class="fw-bold mb-3">
                    <i class="fas fa-question-circle text-info me-2"></i>Need help finding your PNR?
                </h5>
                <div class="row">
                    <div class="col-md-6">
                        <h6 class="fw-bold">Where to find PNR:</h6>
                        <ul class="list-unstyled">
                            <li class="mb-1"><i class="fas fa-envelope me-2 text-primary"></i>Booking confirmation email</li>
                            <li class="mb-1"><i class="fas fa-sms me-2 text-success"></i>SMS confirmation</li>
                            <li class="mb-1"><i class="fas fa-ticket-alt me-2 text-warning"></i>Printed ticket</li>
                            <li class="mb-1"><i class="fas fa-mobile-alt me-2 text-info"></i>Mobile app booking</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6 class="fw-bold">Try sample PNR:</h6>
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-primary btn-sm" onclick="fillSamplePNR('1234567890')">
                                Sample PNR: 1234567890
                            </button>
                            <p class="text-muted small mb-0">
                                <i class="fas fa-info-circle me-1"></i>Use this to test the PNR status feature
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-format PNR input
    document.querySelector('input[name="pnr"]').addEventListener('input', function(e) {
        // Only allow numbers
        this.value = this.value.replace(/[^0-9]/g, '');

        // Convert to uppercase for display
        this.style.textTransform = 'uppercase';
    });

    function fillSamplePNR(pnr) {
        document.querySelector('input[name="pnr"]').value = pnr;
    }

    function printTicket() {
        window.print();
    }

    function downloadTicket() {
        alert('Ticket download feature will be implemented soon!');
    }

    // Focus on PNR input when page loads
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelector('input[name="pnr"]').focus();
    });
</script>
</body>
</html>
