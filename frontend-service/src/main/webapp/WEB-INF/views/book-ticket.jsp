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
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            backdrop-filter: blur(15px);
        }
        .train-info {
            background: linear-gradient(135deg, #3B82F6, #2563EB);
            color: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .form-control, .form-select {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 12px 20px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #3B82F6;
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }
        .btn-book {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border: none;
            border-radius: 12px;
            padding: 15px 40px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .fare-breakdown {
            background: #f8fafc;
            border-radius: 12px;
            padding: 1.5rem;
            border: 2px solid #e2e8f0;
        }
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }
        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 10px;
            font-weight: bold;
        }
        .step.active {
            background: #3B82F6;
            color: white;
        }
        .step.inactive {
            background: #e2e8f0;
            color: #6b7280;
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
            <a class="btn btn-primary" href="/search">New Search</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Progress Steps -->
            <div class="step-indicator">
                <div class="step active">1</div>
                <div class="step inactive">2</div>
                <div class="step inactive">3</div>
            </div>

            <div class="text-center mb-4">
                <h2 class="text-white fw-bold">
                    <i class="fas fa-ticket-alt me-3"></i>Book Your Ticket
                </h2>
                <p class="text-light fs-5">Step 1: Passenger Details</p>
            </div>

            <!-- Selected Train Info -->
            <c:if test="${not empty selectedEvent}">
                <div class="train-info">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h4 class="fw-bold mb-2">
                                <i class="fas fa-train me-2"></i>${selectedEvent.eventName}
                            </h4>
                            <p class="mb-1">Train No: ${selectedEvent.eventCode}</p>
                            <p class="mb-0">
                                <i class="fas fa-route me-2"></i>${selectedEvent.source} → ${selectedEvent.destination}
                            </p>
                        </div>
                        <div class="col-md-3">
                            <h6 class="mb-1">Departure</h6>
                            <p class="mb-0 fs-5 fw-bold">08:00 AM</p>
                        </div>
                        <div class="col-md-3">
                            <h6 class="mb-1">Base Fare</h6>
                            <p class="mb-0 fs-4 fw-bold">₹${selectedEvent.price}</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Booking Form -->
            <div class="booking-card">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>

                <form action="/book-ticket" method="post" id="bookingForm">
                    <input type="hidden" name="eventId" value="${selectedEvent.id}">

                    <div class="row">
                        <!-- Passenger Details -->
                        <div class="col-md-8">
                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-user text-primary me-2"></i>Passenger Information
                            </h5>

                            <div class="row">
                                <div class="col-md-8 mb-3">
                                    <label class="form-label fw-medium">Full Name *</label>
                                    <input type="text" class="form-control" name="passengerName"
                                           placeholder="Enter full name as per ID proof" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label fw-medium">Age *</label>
                                    <input type="number" class="form-control" name="passengerAge"
                                           min="1" max="120" placeholder="Age" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-medium">Gender *</label>
                                    <select class="form-select" name="passengerGender" required>
                                        <option value="">Select Gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-medium">Mobile Number</label>
                                    <input type="tel" class="form-control" name="mobileNumber"
                                           placeholder="10-digit mobile number" pattern="[0-9]{10}">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-medium">Email Address</label>
                                <input type="email" class="form-control" name="email"
                                       placeholder="Email for booking confirmation" value="${user.email}">
                            </div>

                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-train text-primary me-2"></i>Journey Details
                            </h5>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-medium">Travel Class *</label>
                                    <select class="form-select" name="trainClass" id="trainClass" required onchange="updateFare()">
                                        <option value="">Select Class</option>
                                        <option value="SL" data-fare="500">Sleeper (SL) - ₹500</option>
                                        <option value="3A" data-fare="1200">AC 3 Tier (3A) - ₹1,200</option>
                                        <option value="2A" data-fare="1800">AC 2 Tier (2A) - ₹1,800</option>
                                        <option value="1A" data-fare="3000">AC First Class (1A) - ₹3,000</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-medium">Journey Date *</label>
                                    <input type="date" class="form-control" name="journeyDate"
                                           id="journeyDate" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-medium">Boarding Station</label>
                                    <select class="form-select" name="boardingStation">
                                        <option value="${selectedEvent.source}">${selectedEvent.source} (Origin)</option>
                                        <option value="Intermediate">Intermediate Station</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-medium">Food Preference</label>
                                    <select class="form-select" name="foodPreference">
                                        <option value="">No Meal</option>
                                        <option value="Veg">Vegetarian</option>
                                        <option value="NonVeg">Non-Vegetarian</option>
                                        <option value="Vegan">Vegan</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Fare Breakdown -->
                        <div class="col-md-4">
                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-receipt text-primary me-2"></i>Fare Breakdown
                            </h5>

                            <div class="fare-breakdown">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Base Fare:</span>
                                    <span id="baseFare">₹0</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Reservation Charges:</span>
                                    <span id="reservationCharges">₹50</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Service Tax:</span>
                                    <span id="serviceTax">₹0</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Convenience Fee:</span>
                                    <span id="convenienceFee">₹20</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between fw-bold fs-5 text-success">
                                    <span>Total Amount:</span>
                                    <span id="totalAmount">₹70</span>
                                </div>

                                <div class="mt-4">
                                    <h6 class="fw-bold mb-2">Included Benefits:</h6>
                                    <ul class="list-unstyled small">
                                        <li><i class="fas fa-check text-success me-2"></i>Free Cancellation</li>
                                        <li><i class="fas fa-check text-success me-2"></i>SMS & Email Updates</li>
                                        <li><i class="fas fa-check text-success me-2"></i>24/7 Customer Support</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="mt-4">
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="terms" required>
                                    <label class="form-check-label small" for="terms">
                                        I agree to the <a href="#" class="text-primary">Terms & Conditions</a>
                                    </label>
                                </div>

                                <div class="form-check mb-4">
                                    <input class="form-check-input" type="checkbox" id="notifications">
                                    <label class="form-check-label small" for="notifications">
                                        Send me booking updates via SMS & Email
                                    </label>
                                </div>

                                <button type="submit" class="btn btn-success btn-book w-100">
                                    <i class="fas fa-credit-card me-2"></i>Proceed to Pay
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set minimum date to today
    document.getElementById('journeyDate').min = new Date().toISOString().split('T')[0];

    // Set default date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById('journeyDate').value = tomorrow.toISOString().split('T')[0];

    function updateFare() {
        const classSelect = document.getElementById('trainClass');
        const selectedOption = classSelect.options[classSelect.selectedIndex];
        const baseFare = selectedOption.getAttribute('data-fare') || 0;

        const reservationCharges = 50;
        const serviceTax = Math.round(baseFare * 0.05);
        const convenienceFee = 20;
        const total = parseInt(baseFare) + reservationCharges + serviceTax + convenienceFee;

        document.getElementById('baseFare').textContent = '₹' + baseFare;
        document.getElementById('serviceTax').textContent = '₹' + serviceTax;
        document.getElementById('totalAmount').textContent = '₹' + total;
    }

    // Form validation
    document.getElementById('bookingForm').addEventListener('submit', function(e) {
        const requiredFields = this.querySelectorAll('[required]');
        let isValid = true;

        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                field.classList.add('is-invalid');
                isValid = false;
            } else {
                field.classList.remove('is-invalid');
            }
        });

        if (!isValid) {
            e.preventDefault();
            alert('Please fill in all required fields.');
        }
    });

    // Auto-capitalize name
    document.querySelector('input[name="passengerName"]').addEventListener('input', function() {
        this.value = this.value.toUpperCase();
    });
</script>
</body>
</html>
