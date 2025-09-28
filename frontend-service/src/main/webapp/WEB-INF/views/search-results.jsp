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
        .search-header {
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(15px);
        }
        .train-card {
            background: rgba(255,255,255,0.95);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .train-card:hover {
            transform: translateY(-5px);
        }
        .price-badge {
            background: linear-gradient(135deg, #059669, #10b981);
            color: white;
            border-radius: 20px;
            padding: 8px 16px;
            font-weight: bold;
        }
        .book-btn {
            background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%);
            border: none;
            border-radius: 12px;
            padding: 12px 25px;
            font-weight: 600;
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
            <a class="btn btn-primary" href="/search">New Search</a>
        </div>
    </div>
</nav>

<div class="container">
    <!-- Search Summary -->
    <div class="search-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h3 class="text-primary fw-bold mb-2">
                    <i class="fas fa-route me-2"></i>${searchQuery.source} → ${searchQuery.destination}
                </h3>
                <p class="text-muted mb-0">
                    <i class="fas fa-calendar me-2"></i>Travel Date: ${searchQuery.travelDate} |
                    <c:choose>
                        <c:when test="${not empty trains}">
                            <span class="text-success">${trains.size()} trains found</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-warning">0 trains found</span>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div class="col-md-4 text-end">
                <a href="/search" class="btn btn-outline-primary">
                    <i class="fas fa-edit me-2"></i>Modify Search
                </a>
            </div>
        </div>
    </div>

    <!-- Train Results -->
    <c:choose>
        <c:when test="${not empty trains}">
            <c:forEach var="train" items="${trains}">
                <div class="train-card">
                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <h5 class="fw-bold text-primary mb-1">${train.eventName}</h5>
                            <p class="text-muted mb-0">#${train.eventCode}</p>
                            <span class="badge bg-secondary">${train.eventType}</span>
                        </div>
                        <div class="col-md-2 text-center">
                            <div class="departure-time">
                                <h5 class="fw-bold mb-0">08:00</h5>
                                <small class="text-muted">${train.source}</small>
                            </div>
                        </div>
                        <div class="col-md-2 text-center">
                            <i class="fas fa-arrow-right text-primary fa-2x"></i>
                            <br><small class="text-muted">16h 30m</small>
                        </div>
                        <div class="col-md-2 text-center">
                            <div class="arrival-time">
                                <h5 class="fw-bold mb-0">00:30</h5>
                                <small class="text-muted">${train.destination}</small>
                            </div>
                        </div>
                        <div class="col-md-2 text-center">
                            <div class="price-badge">
                                ₹${train.price}
                            </div>
                            <small class="text-success d-block mt-1">
                                <i class="fas fa-check-circle me-1"></i>Available: ${train.availableSeats}
                            </small>
                        </div>
                        <div class="col-md-1 text-center">
                            <c:choose>
                                <c:when test="${isLoggedIn}">
                                    <button class="btn btn-primary book-btn"
                                            onclick="bookTrain('${train.id}', '${train.eventName}')">
                                        <i class="fas fa-ticket-alt me-1"></i>Book
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="/login" class="btn btn-primary book-btn">
                                        Login to Book
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Train Details Row -->
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <p class="text-muted mb-0">
                                <i class="fas fa-info-circle me-1"></i>${train.description}
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="train-card text-center py-5">
                <i class="fas fa-search fa-4x text-muted mb-3"></i>
                <h4 class="text-muted mb-3">No trains found</h4>
                <p class="text-muted mb-4">
                    We couldn't find any trains from <strong>${searchQuery.source}</strong>
                    to <strong>${searchQuery.destination}</strong> on <strong>${searchQuery.travelDate}</strong>.
                </p>
                <div class="alert alert-info">
                    <i class="fas fa-lightbulb me-2"></i>
                    <strong>Suggestions:</strong>
                    <ul class="list-unstyled mt-2 mb-0">
                        <li>• Try different cities or dates</li>
                        <li>• Check spelling of station names</li>
                        <li>• Try searching for nearby stations</li>
                    </ul>
                </div>
                <div class="mt-4">
                    <a href="/search" class="btn btn-primary me-3">
                        <i class="fas fa-search me-2"></i>Search Again
                    </a>
                    <a href="/admin/create-demo-data" class="btn btn-outline-secondary">
                        <i class="fas fa-plus me-2"></i>Add Demo Data
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Booking Modal -->
<div class="modal fade" id="bookingModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-ticket-alt me-2"></i>Book Ticket
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="bookingForm" action="/book-ticket" method="post">
                    <input type="hidden" id="eventId" name="eventId">

                    <div class="mb-3">
                        <label class="form-label">Passenger Name *</label>
                        <input type="text" class="form-control" name="passengerName" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Age *</label>
                            <input type="number" class="form-control" name="passengerAge" min="1" max="120" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Gender *</label>
                            <select class="form-select" name="passengerGender" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Train Class *</label>
                            <select class="form-select" name="trainClass" required>
                                <option value="SL">Sleeper (SL)</option>
                                <option value="3A">AC 3 Tier (3A)</option>
                                <option value="2A">AC 2 Tier (2A)</option>
                                <option value="1A">AC First Class (1A)</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Journey Date *</label>
                            <input type="date" class="form-control" name="journeyDate"
                                   value="${searchQuery.travelDate}" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-credit-card me-2"></i>Proceed to Book
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function bookTrain(eventId, trainName) {
        document.getElementById('eventId').value = eventId;
        document.querySelector('#bookingModal .modal-title').innerHTML =
            '<i class="fas fa-ticket-alt me-2"></i>Book Ticket - ' + trainName;

        const modal = new bootstrap.Modal(document.getElementById('bookingModal'));
        modal.show();
    }
</script>
</body>
</html>
