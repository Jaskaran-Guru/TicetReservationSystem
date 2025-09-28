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
        .search-card {
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 3rem;
            margin: 2rem 0;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            backdrop-filter: blur(15px);
        }
        .form-floating > .form-control {
            border-radius: 16px;
            border: 2px solid #e2e8f0;
            padding-left: 50px;
        }
        .form-floating > .form-control:focus {
            border-color: #3B82F6;
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }
        .form-floating > label {
            padding-left: 50px;
        }
        .form-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10;
            color: #6b7280;
        }
        .btn-search {
            background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%);
            border: none;
            border-radius: 16px;
            padding: 18px 40px;
            font-size: 18px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
        }
        .btn-search:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(59, 130, 246, 0.4);
        }
        .quick-search {
            background: rgba(255,255,255,0.9);
            border-radius: 16px;
            padding: 1.5rem;
            margin-top: 2rem;
        }
        .route-btn {
            border: 2px solid #3B82F6;
            border-radius: 12px;
            padding: 10px 20px;
            margin: 5px;
            background: transparent;
            color: #3B82F6;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .route-btn:hover {
            background: #3B82F6;
            color: white;
            transform: translateY(-2px);
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
            <c:choose>
                <c:when test="${isLoggedIn}">
                    <a class="nav-link text-dark" href="/dashboard">Dashboard</a>
                    <a class="nav-link text-dark" href="/my-bookings">My Bookings</a>
                    <a class="btn btn-primary" href="/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a class="nav-link text-dark" href="/login">Login</a>
                    <a class="btn btn-primary" href="/register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container">
    <div class="text-center mb-4">
        <h1 class="text-white fw-bold display-4 mb-3">
            <i class="fas fa-search me-3"></i>Search Trains
        </h1>
        <p class="text-light fs-5">Find the perfect train for your journey</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="search-card">
                <form action="/search" method="post">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="position-relative">
                                <i class="fas fa-map-marker-alt form-icon text-success"></i>
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="source" name="source"
                                           placeholder="From Station" list="sourceList" required>
                                    <label for="source">From Station</label>
                                </div>
                                <datalist id="sourceList">
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Hyderabad">Hyderabad</option>
                                    <option value="Pune">Pune</option>
                                    <option value="Jaipur">Jaipur</option>
                                    <option value="Chandigarh">Chandigarh</option>
                                </datalist>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="position-relative">
                                <i class="fas fa-map-marker-alt form-icon text-danger"></i>
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="destination" name="destination"
                                           placeholder="To Station" list="destinationList" required>
                                    <label for="destination">To Station</label>
                                </div>
                                <datalist id="destinationList">
                                    <option value="Bangalore">Bangalore</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="Chennai">Chennai</option>
                                    <option value="Kolkata">Kolkata</option>
                                    <option value="Hyderabad">Hyderabad</option>
                                    <option value="Pune">Pune</option>
                                    <option value="Jaipur">Jaipur</option>
                                    <option value="Chandigarh">Chandigarh</option>
                                </datalist>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="position-relative">
                                <i class="fas fa-calendar-alt form-icon text-info"></i>
                                <div class="form-floating">
                                    <input type="date" class="form-control" id="travelDate" name="travelDate" required>
                                    <label for="travelDate">Journey Date</label>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="position-relative">
                                <i class="fas fa-train form-icon text-warning"></i>
                                <div class="form-floating">
                                    <select class="form-select" id="trainClass" name="trainClass">
                                        <option value="">All Classes</option>
                                        <option value="SL">Sleeper (SL)</option>
                                        <option value="3A">AC 3 Tier (3A)</option>
                                        <option value="2A">AC 2 Tier (2A)</option>
                                        <option value="1A">AC First Class (1A)</option>
                                    </select>
                                    <label for="trainClass">Travel Class</label>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="position-relative">
                                <i class="fas fa-users form-icon text-purple"></i>
                                <div class="form-floating">
                                    <select class="form-select" id="passengerCount" name="passengerCount">
                                        <option value="1">1 Passenger</option>
                                        <option value="2">2 Passengers</option>
                                        <option value="3">3 Passengers</option>
                                        <option value="4">4 Passengers</option>
                                        <option value="5">5 Passengers</option>
                                        <option value="6">6 Passengers</option>
                                    </select>
                                    <label for="passengerCount">Passengers</label>
                                </div>
                            </div>
                        </div>

                        <!-- Advanced Options -->
                        <div class="col-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="flexibleDates" name="flexibleDates">
                                <label class="form-check-label" for="flexibleDates">
                                    <i class="fas fa-calendar-week me-2"></i>Flexible with dates (±3 days)
                                </label>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="availableOnly" name="availableOnly" checked>
                                <label class="form-check-label" for="availableOnly">
                                    <i class="fas fa-check-circle me-2"></i>Show only available trains
                                </label>
                            </div>
                        </div>

                        <div class="col-12 mt-5">
                            <button type="submit" class="btn btn-primary btn-search w-100">
                                <i class="fas fa-search me-3"></i>SEARCH TRAINS
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Quick Search Routes -->
            <div class="quick-search">
                <h5 class="fw-bold mb-3 text-center">
                    <i class="fas fa-bolt text-warning me-2"></i>Popular Routes
                </h5>
                <div class="text-center">
                    <button class="btn route-btn" onclick="fillRoute('Delhi', 'Mumbai')">Delhi ↔ Mumbai</button>
                    <button class="btn route-btn" onclick="fillRoute('Bangalore', 'Chennai')">Bangalore ↔ Chennai</button>
                    <button class="btn route-btn" onclick="fillRoute('Delhi', 'Kolkata')">Delhi ↔ Kolkata</button>
                    <button class="btn route-btn" onclick="fillRoute('Mumbai', 'Pune')">Mumbai ↔ Pune</button>
                    <button class="btn route-btn" onclick="fillRoute('Delhi', 'Jaipur')">Delhi ↔ Jaipur</button>
                    <button class="btn route-btn" onclick="fillRoute('Bangalore', 'Hyderabad')">Bangalore ↔ Hyderabad</button>
                </div>
            </div>

            <!-- Search Tips -->
            <div class="quick-search mt-3">
                <h6 class="fw-bold mb-3">
                    <i class="fas fa-lightbulb text-warning me-2"></i>Search Tips
                </h6>
                <div class="row">
                    <div class="col-md-6">
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Book in advance for better availability</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Try flexible dates for more options</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Check different train classes</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Consider nearby stations</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set minimum date to today
    document.getElementById('travelDate').min = new Date().toISOString().split('T')[0];

    // Set default date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById('travelDate').value = tomorrow.toISOString().split('T')[0];

    function fillRoute(from, to) {
        document.getElementById('source').value = from;
        document.getElementById('destination').value = to;
    }

    // Swap stations
    function swapStations() {
        const source = document.getElementById('source').value;
        const destination = document.getElementById('destination').value;

        document.getElementById('source').value = destination;
        document.getElementById('destination').value = source;
    }

    // Add swap button after page loads
    document.addEventListener('DOMContentLoaded', function() {
        const sourceCol = document.querySelector('.col-md-6');
        const swapBtn = document.createElement('button');
        swapBtn.type = 'button';
        swapBtn.className = 'btn btn-outline-primary btn-sm position-absolute';
        swapBtn.style.cssText = 'top: 50%; right: -20px; transform: translateY(-50%); z-index: 1000; border-radius: 50%; width: 40px; height: 40px;';
        swapBtn.innerHTML = '<i class="fas fa-exchange-alt"></i>';
        swapBtn.onclick = swapStations;
        swapBtn.title = 'Swap stations';

        sourceCol.style.position = 'relative';
        sourceCol.appendChild(swapBtn);
    });
</script>
</body>
</html>
