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
            padding: 2rem 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .register-card {
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 70px rgba(0,0,0,0.2);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.3);
            margin: 2rem 0;
        }
        .form-control {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 12px 20px 12px 50px;
        }
        .form-control:focus {
            border-color: #3B82F6;
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }
        .input-group-text {
            border-radius: 12px 0 0 12px;
            border: 2px solid #e2e8f0;
            border-right: none;
            background: #f8fafc;
        }
        .btn-primary {
            background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%);
            border: none;
            border-radius: 12px;
            padding: 15px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .brand-title {
            background: linear-gradient(135deg, #3B82F6, #1D4ED8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="register-card">
                <div class="text-center mb-4">
                    <h2 class="fw-bold brand-title">
                        <i class="fas fa-train text-primary me-2"></i>WaygonWay
                    </h2>
                    <p class="text-muted fs-5">Create your account to start booking</p>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="/register" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">First Name *</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-user text-primary"></i>
                                    </span>
                                <input type="text" class="form-control" name="firstName"
                                       placeholder="Enter first name" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Last Name *</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-user text-primary"></i>
                                    </span>
                                <input type="text" class="form-control" name="lastName"
                                       placeholder="Enter last name" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Email Address *</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-envelope text-primary"></i>
                                    </span>
                                <input type="email" class="form-control" name="email"
                                       placeholder="Enter email address" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Phone Number</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-phone text-primary"></i>
                                    </span>
                                <input type="tel" class="form-control" name="phone"
                                       placeholder="Enter phone number">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Username *</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-at text-primary"></i>
                                    </span>
                                <input type="text" class="form-control" name="username"
                                       placeholder="Choose username" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">Password *</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-lock text-primary"></i>
                                    </span>
                                <input type="password" class="form-control" name="password"
                                       placeholder="Create password" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">City</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-city text-primary"></i>
                                    </span>
                                <input type="text" class="form-control" name="city"
                                       placeholder="Enter city">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-medium">State</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-map-marker-alt text-primary"></i>
                                    </span>
                                <input type="text" class="form-control" name="state"
                                       placeholder="Enter state">
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-4">
                        <i class="fas fa-user-plus me-2"></i>Create Account
                    </button>
                </form>

                <div class="text-center">
                    <p class="text-muted mb-3">
                        Already have an account?
                        <a href="/login" class="text-primary fw-bold text-decoration-none">Sign In</a>
                    </p>
                    <a href="/" class="text-muted text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i>Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
