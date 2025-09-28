<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - WaygonWay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #4F46E5 0%, #3B82F6 25%, #2563EB 50%, #1D4ED8 100%); min-height: 100vh; padding-top: 76px; }
        .navbar { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); }
        .admin-card { background: rgba(255,255,255,0.95); border-radius: 20px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .stat-card { background: linear-gradient(135deg, #3B82F6, #2563EB); color: white; border-radius: 16px; padding: 2rem; text-align: center; }
        .btn-admin { background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%); border: none; border-radius: 12px; padding: 12px 25px; font-weight: 600; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold fs-3 text-primary" href="/"><i class="fas fa-train me-2"></i>WaygonWay</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-dark" href="/admin/create-demo-data">Demo Data</a>
            <a class="btn btn-primary" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="admin-card">
        <h2 class="text-primary fw-bold mb-4"><i class="fas fa-crown me-3"></i>Admin Dashboard</h2>
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-users fa-3x mb-3"></i>
                    <h3>150</h3>
                    <p>Total Users</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-train fa-3x mb-3"></i>
                    <h3>25</h3>
                    <p>Total Trains</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-ticket-alt fa-3x mb-3"></i>
                    <h3>89</h3>
                    <p>Bookings Today</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-rupee-sign fa-3x mb-3"></i>
                    <h3>₹45,000</h3>
                    <p>Revenue Today</p>
                </div>
            </div>
        </div>
    </div>

    <div class="admin-card">
        <h4 class="fw-bold mb-4"><i class="fas fa-tools text-primary me-2"></i>Quick Actions</h4>
        <div class="row">
            <div class="col-md-4 mb-3">
                <a href="/admin/create-demo-data" class="btn btn-admin w-100">
                    <i class="fas fa-plus me-2"></i>Create Demo Data
                </a>
            </div>
            <div class="col-md-4 mb-3">
                <button class="btn btn-outline-primary w-100" onclick="exportData()">
                    <i class="fas fa-download me-2"></i>Export Data
                </button>
            </div>
            <div class="col-md-4 mb-3">
                <button class="btn btn-outline-success w-100" onclick="viewReports()">
                    <i class="fas fa-chart-bar me-2"></i>View Reports
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function exportData() { alert('Data export started!'); }
    function viewReports() { window.location.href = '/admin/reports'; }
</script>
</body>
</html>
