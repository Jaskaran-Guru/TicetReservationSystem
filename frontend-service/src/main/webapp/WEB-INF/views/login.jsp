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
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            background: rgba(255,255,255,0.98);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 70px rgba(0,0,0,0.2);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.3);
        }
        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label {
            color: #3B82F6;
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
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
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
        <div class="col-lg-5 col-md-7">
            <div class="login-card">
                <div class="text-center mb-4">
                    <h2 class="fw-bold brand-title">
                        <i class="fas fa-train text-primary me-2"></i>WaygonWay
                    </h2>
                    <p class="text-muted fs-5">Welcome back! Please sign in to your account</p>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="/login" method="post">
                    <div class="mb-4">
                        <label class="form-label fw-medium">Username or Email</label>
                        <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-user text-primary"></i>
                                </span>
                            <input type="text" class="form-control" name="usernameOrEmail"
                                   placeholder="Enter your username or email" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-medium">Password</label>
                        <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock text-primary"></i>
                                </span>
                            <input type="password" class="form-control" name="password"
                                   placeholder="Enter your password" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-4">
                        <i class="fas fa-sign-in-alt me-2"></i>Sign In
                    </button>
                </form>

                <div class="text-center">
                    <p class="text-muted mb-3">
                        Don't have an account?
                        <a href="/register" class="text-primary fw-bold text-decoration-none">Create Account</a>
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
