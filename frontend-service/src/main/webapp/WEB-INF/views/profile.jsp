<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - WaygonWay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #4F46E5 0%, #3B82F6 25%, #2563EB 50%, #1D4ED8 100%); min-height: 100vh; padding-top: 76px; }
        .navbar { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); }
        .profile-card { background: rgba(255,255,255,0.95); border-radius: 20px; padding: 2.5rem; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .form-control { border-radius: 12px; border: 2px solid #e2e8f0; padding: 12px 20px; }
        .form-control:focus { border-color: #3B82F6; box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25); }
        .btn-update { background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%); border: none; border-radius: 12px; padding: 12px 30px; font-weight: 600; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold fs-3 text-primary" href="/"><i class="fas fa-train me-2"></i>WaygonWay</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-dark" href="/dashboard">Dashboard</a>
            <a class="btn btn-primary" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="profile-card">
                <div class="text-center mb-4">
                    <i class="fas fa-user-circle fa-5x text-primary mb-3"></i>
                    <h2 class="fw-bold text-primary">My Profile</h2>
                    <p class="text-muted">Manage your account information</p>
                </div>

                <form action="/profile/update" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">First Name</label>
                            <input type="text" class="form-control" name="firstName" value="${user.firstName}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Last Name</label>
                            <input type="text" class="form-control" name="lastName" value="${user.lastName}" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-medium">Email Address</label>
                        <input type="email" class="form-control" name="email" value="${user.email}" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Phone Number</label>
                            <input type="tel" class="form-control" name="phone" value="${user.phone}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Username</label>
                            <input type="text" class="form-control" name="username" value="${user.username}" readonly>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">City</label>
                            <input type="text" class="form-control" name="city" value="${user.city}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">State</label>
                            <input type="text" class="form-control" name="state" value="${user.state}">
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary btn-update">
                            <i class="fas fa-save me-2"></i>Update Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
