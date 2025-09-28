<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - WaygonWay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #4F46E5 0%, #3B82F6 25%, #2563EB 50%, #1D4ED8 100%); min-height: 100vh; }
        .error-container { min-height: 100vh; display: flex; align-items: center; }
        .error-card { background: rgba(255,255,255,0.95); border-radius: 24px; padding: 3rem; text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.15); }
    </style>
</head>
<body>
<div class="error-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="error-card">
                    <i class="fas fa-train fa-5x text-primary mb-4"></i>
                    <h1 class="display-1 fw-bold text-primary">404</h1>
                    <h2 class="mb-4">Page Not Found</h2>
                    <p class="lead mb-4">The page you're looking for doesn't exist.</p>
                    <div>
                        <a href="/" class="btn btn-primary btn-lg me-3">
                            <i class="fas fa-home me-2"></i>Go Home
                        </a>
                        <a href="/search" class="btn btn-outline-primary btn-lg">
                            <i class="fas fa-search me-2"></i>Search Trains
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
