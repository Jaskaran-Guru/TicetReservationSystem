<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management - WaygonWay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #4F46E5 0%, #3B82F6 25%, #2563EB 50%, #1D4ED8 100%); min-height: 100vh; padding-top: 76px; }
        .navbar { background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); }
        .users-card { background: rgba(255,255,255,0.95); border-radius: 20px; padding: 2rem; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold fs-3 text-primary" href="/"><i class="fas fa-train me-2"></i>WaygonWay</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-dark" href="/admin-dashboard">Admin Dashboard</a>
            <a class="btn btn-primary" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="users-card">
        <h2 class="text-primary fw-bold mb-4"><i class="fas fa-users me-3"></i>User Management</h2>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>John Doe</td>
                    <td>john@example.com</td>
                    <td><span class="badge bg-secondary">USER</span></td>
                    <td><span class="badge bg-success">Active</span></td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary">Edit</button>
                        <button class="btn btn-sm btn-outline-danger">Disable</button>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Admin User</td>
                    <td>admin@waygonway.com</td>
                    <td><span class="badge bg-warning">ADMIN</span></td>
                    <td><span class="badge bg-success">Active</span></td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary">Edit</button>
                        <button class="btn btn-sm btn-outline-info">View</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
