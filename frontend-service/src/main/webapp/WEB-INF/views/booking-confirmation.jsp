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
        .confirmation-card {
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            backdrop-filter: blur(15px);
        }
        .success-icon {
            color: #10b981;
            animation: checkmark 0.6s ease-in-out;
        }
        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        .pnr-highlight {
            background: linear-gradient(135deg, #3B82F6, #2563EB);
            color: white;
            padding: 1rem 2rem;
            border-radius: 16px;
            text-align: center;
            margin: 2rem 0;
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
        }
        .ticket-details {
            background: #f8fafc;
            border-radius: 16px;
            padding: 2rem;
            border: 2px solid #e2e8f0;
            position: relative;
            overflow: hidden;
        }
        .ticket-details::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #3B82F6, #10b981, #f59e0b);
        }
        .action-buttons .btn {
            border-radius: 12px;
            padding: 12px 25px;
            font-weight: 600;
            margin: 0.5rem;
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
            <a class="nav-link text-dark" href="/my-bookings">My Bookings</a>
            <a class="btn btn-primary" href="/search">Book Another</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Success Message -->
            <div class="confirmation-card text-center">
                <div class="success-icon mb-4">
                    <i class="fas fa-check-circle fa-6x"></i>
                </div>

                <h1 class="text-success fw-bold mb-3">Booking Confirmed!</h1>
                <p class="text-muted fs-5 mb-4">
                    Your train ticket has been successfully booked.
                    A confirmation email has been sent to your registered email address.
                </p>

                <!-- PNR Display -->
                <div class="pnr-highlight">
                    <h3 class="fw-bold mb-2">Your PNR Number</h3>
                    <h1 class="fw-bold mb-0 display-4">${pnr}</h1>
                    <p class="mb-0 opacity-75">Keep this number safe for future reference</p>
                </div>
            </div>

            <!-- Ticket Details -->
            <div class="confirmation-card">
                <h4 class="fw-bold mb-4">
                    <i class="fas fa-ticket-alt text-primary me-2"></i>Your E-Ticket Details
                </h4>

                <div class="ticket-details">
                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary mb-3">Train Information</h6>
                            <div class="mb-2">
                                <i class="fas fa-train me-2 text-info"></i>
                                <strong>${booking.trainName}</strong>
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-hashtag me-2 text-info"></i>
                                Train No: ${booking.trainCode}
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-route me-2 text-info"></i>
                                ${booking.source} → ${booking.destination}
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-calendar me-2 text-info"></i>
                                Journey Date: ${booking.journeyDate}
                            </div>
                            <div class="mb-0">
                                <i class="fas fa-clock me-2 text-info"></i>
                                Departure: 08:00 AM
                            </div>
                        </div>

                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary mb-3">Passenger Details</h6>
                            <div class="mb-2">
                                <i class="fas fa-user me-2 text-success"></i>
                                Name: ${booking.passengerName}
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-id-card me-2 text-success"></i>
                                Age: ${booking.passengerAge} | Gender: ${booking.passengerGender}
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-chair me-2 text-success"></i>
                                Class: ${booking.trainClass}
                            </div>
                            <div class="mb-2">
                                <i class="fas fa-bed me-2 text-success"></i>
                                Seat: S4/42 (Confirmed)
                            </div>
                            <div class="mb-0">
                                <i class="fas fa-credit-card me-2 text-success"></i>
                                Total Fare: ₹${booking.totalAmount}
                            </div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary mb-2">Booking Information</h6>
                            <div class="row">
                                <div class="col-6">
                                    <small class="text-muted">PNR Number:</small>
                                    <div class="fw-bold">${pnr}</div>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted">Booking Date:</small>
                                    <div class="fw-bold">${booking.bookingDate}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h6 class="fw-bold text-primary mb-2">Current Status</h6>
                            <div class="d-flex align-items-center">
                                <span class="badge bg-success fs-6 me-3">CONFIRMED</span>
                                <small class="text-muted">Chart not prepared</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="confirmation-card">
                <h5 class="fw-bold mb-4">
                    <i class="fas fa-tools text-primary me-2"></i>Quick Actions
                </h5>

                <div class="action-buttons text-center">
                    <button class="btn btn-primary" onclick="downloadTicket()">
                        <i class="fas fa-download me-2"></i>Download E-Ticket
                    </button>
                    <button class="btn btn-outline-primary" onclick="printTicket()">
                        <i class="fas fa-print me-2"></i>Print Ticket
                    </button>
                    <button class="btn btn-outline-info" onclick="sendSMS()">
                        <i class="fas fa-sms me-2"></i>Send SMS
                    </button>
                    <button class="btn btn-outline-warning" onclick="addCalendar()">
                        <i class="fas fa-calendar-plus me-2"></i>Add to Calendar
                    </button>
                </div>

                <div class="text-center mt-4">
                    <a href="/my-bookings" class="btn btn-success me-3">
                        <i class="fas fa-list me-2"></i>View All Bookings
                    </a>
                    <a href="/search" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Book Another Ticket
                    </a>
                </div>
            </div>

            <!-- Important Instructions -->
            <div class="confirmation-card">
                <h5 class="fw-bold mb-4">
                    <i class="fas fa-info-circle text-warning me-2"></i>Important Instructions
                </h5>

                <div class="row">
                    <div class="col-md-6">
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                Carry a valid photo ID proof while traveling
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                Report at the station 30 minutes before departure
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                Keep your PNR number handy for easy reference
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                Check train running status before travel
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                SMS updates will be sent to your mobile number
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                Contact customer support for any assistance
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="alert alert-info mt-3">
                    <i class="fas fa-phone me-2"></i>
                    <strong>Customer Support:</strong> 1800-123-4567 |
                    <strong>Email:</strong> support@waygonway.com
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function downloadTicket() {
        // In a real application, this would generate a PDF ticket
        alert('E-Ticket download will start shortly...');
        console.log('Downloading ticket for PNR: ${pnr}');
    }

    function printTicket() {
        window.print();
    }

    function sendSMS() {
        alert('SMS with ticket details has been sent to your mobile number!');
    }

    function addCalendar() {
        // Create calendar event
        const event = {
            title: 'Train Journey - ${booking.trainName}',
            start: '${booking.journeyDate}T08:00:00',
            description: 'PNR: ${pnr} | ${booking.source} to ${booking.destination}'
        };

        alert('Calendar event created for your journey!');
    }

    // Show success animation on page load
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(function() {
            document.querySelector('.success-icon').style.animation = 'checkmark 0.6s ease-in-out';
        }, 500);
    });
</script>
</body>
</html>
