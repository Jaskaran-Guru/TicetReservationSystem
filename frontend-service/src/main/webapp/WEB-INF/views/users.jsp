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
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            /* Elegant & Sophisticated Color Scheme */
            --charcoal-deep: #1a1a1a;
            --charcoal: #2d2d2d;
            --charcoal-light: #3d3d3d;
            --slate: #4a5568;
            --slate-light: #64748b;
            --rose: #d4638f;
            --rose-deep: #b85577;
            --rose-light: #e89bb5;
            --champagne: #f5e6d3;
            --champagne-light: #faf3e8;
            --cream: #fef9f3;
            --silver: #e5e7eb;
            --pearl: #f8f9fa;
            --white: #ffffff;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            background: linear-gradient(135deg, var(--charcoal-deep) 0%, var(--charcoal) 30%, var(--slate) 70%, var(--slate-light) 100%);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
            padding-top: 76px;
        }

        /* Elegant Background Pattern */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background:
                radial-gradient(circle at 20% 20%, rgba(212, 99, 143, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(245, 230, 211, 0.06) 0%, transparent 50%),
                radial-gradient(circle at 50% 50%, rgba(45, 45, 45, 0.6) 0%, transparent 100%);
            z-index: 0;
            pointer-events: none;
        }

        body::after {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
            background-size: 50px 50px;
            z-index: 0;
            pointer-events: none;
            opacity: 0.3;
        }

        /* Navbar */
        .navbar {
            background: rgba(26, 26, 26, 0.95);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border-bottom: 1px solid rgba(212, 99, 143, 0.2);
            padding: 1rem 0;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
        }

        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-weight: 800;
            font-size: 1.7rem !important;
            color: var(--white) !important;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-brand i {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--rose) 0%, var(--rose-light) 100%);
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(212, 99, 143, 0.3);
        }

        .nav-link {
            color: rgba(255,255,255,0.75) !important;
            font-weight: 500;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
            padding: 0.5rem 1rem !important;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--champagne) !important;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--rose), var(--rose-deep)) !important;
            border: none !important;
            color: var(--white) !important;
            font-size: 0.9rem !important;
            font-weight: 600 !important;
            padding: 0.5rem 1.5rem !important;
            border-radius: 10px !important;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 15px rgba(212, 99, 143, 0.3) !important;
        }

        .btn-primary:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 6px 25px rgba(212, 99, 143, 0.4) !important;
        }

        /* Users Card */
        .users-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.08) 0%, rgba(255, 255, 255, 0.04) 100%);
            border: 1px solid rgba(212, 99, 143, 0.2);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border-radius: 32px;
            padding: 3rem;
            margin: 2rem auto;
            box-shadow:
                0 0 0 1px rgba(255,255,255,0.05),
                0 30px 90px rgba(0, 0, 0, 0.5),
                inset 0 1px 0 rgba(255,255,255,0.1);
            position: relative;
            z-index: 1;
            animation: fade-scale 0.6s ease both;
        }

        @keyframes fade-scale {
            from { opacity: 0; transform: translateY(30px) scale(0.95); }
            to   { opacity: 1; transform: translateY(0) scale(1); }
        }

        .users-card h2 {
            font-family: 'Playfair Display', serif;
            font-weight: 800;
            font-size: 2rem;
            color: var(--white);
            margin-bottom: 2rem;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .users-card h2 i {
            width: 52px;
            height: 52px;
            background: linear-gradient(135deg, var(--rose), var(--rose-deep));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            box-shadow: 0 8px 25px rgba(212, 99, 143, 0.3);
        }

        /* Table Styles */
        .table-responsive {
            background: rgba(255, 255, 255, 0.03);
            border-radius: 20px;
            padding: 1.5rem;
            border: 1px solid rgba(212, 99, 143, 0.15);
        }

        .table {
            color: var(--white);
            margin-bottom: 0;
        }

        .table thead {
            background: linear-gradient(135deg, rgba(212, 99, 143, 0.15), rgba(245, 230, 211, 0.08));
            border-radius: 12px;
        }

        .table-primary {
            --bs-table-bg: transparent !important;
        }

        .table thead th {
            color: var(--champagne) !important;
            font-weight: 700;
            font-size: 0.75rem;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            padding: 1.2rem 1rem;
            border: none;
            background: transparent !important;
        }

        .table tbody tr {
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s ease;
        }

        .table-hover tbody tr:hover {
            background: rgba(212, 99, 143, 0.08) !important;
            transform: translateX(4px);
        }

        .table tbody tr:last-child {
            border-bottom: none;
        }

        .table tbody td {
            padding: 1.2rem 1rem;
            color: rgba(255, 255, 255, 0.85);
            font-weight: 500;
            vertical-align: middle;
            border: none;
        }

        /* Badges */
        .badge {
            font-weight: 600;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-transform: uppercase;
        }

        .badge.bg-secondary {
            background: rgba(100, 116, 139, 0.2) !important;
            color: var(--silver) !important;
            border: 1px solid rgba(100, 116, 139, 0.3);
        }

        .badge.bg-warning {
            background: rgba(245, 230, 211, 0.2) !important;
            color: var(--champagne) !important;
            border: 1px solid rgba(245, 230, 211, 0.3);
        }

        .badge.bg-success {
            background: rgba(52, 211, 153, 0.15) !important;
            color: #6ee7b7 !important;
            border: 1px solid rgba(52, 211, 153, 0.3);
        }

        /* Action Buttons */
        .btn-sm {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            letter-spacing: 0.3px;
        }

        .btn-outline-primary {
            background: transparent !important;
            border: 1.5px solid rgba(212, 99, 143, 0.4) !important;
            color: var(--rose-light) !important;
        }

        .btn-outline-primary:hover {
            background: rgba(212, 99, 143, 0.15) !important;
            border-color: var(--rose) !important;
            color: var(--rose-light) !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(212, 99, 143, 0.2);
        }

        .btn-outline-danger {
            background: transparent !important;
            border: 1.5px solid rgba(239, 68, 68, 0.4) !important;
            color: #fca5a5 !important;
        }

        .btn-outline-danger:hover {
            background: rgba(239, 68, 68, 0.15) !important;
            border-color: rgba(239, 68, 68, 0.6) !important;
            color: #fca5a5 !important;
            transform: translateY(-2px);
        }

        .btn-outline-info {
            background: transparent !important;
            border: 1.5px solid rgba(245, 230, 211, 0.4) !important;
            color: var(--champagne) !important;
        }

        .btn-outline-info:hover {
            background: rgba(245, 230, 211, 0.15) !important;
            border-color: var(--champagne) !important;
            color: var(--champagne-light) !important;
            transform: translateY(-2px);
        }

        /* Floating Orbs */
        .floating-shapes {
            position: fixed;
            inset: 0;
            pointer-events: none;
            overflow: hidden;
            z-index: 0;
        }

        .shape {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            animation: float-orb 12s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(212, 99, 143, 0.12), transparent);
            top: 10%; left: 10%;
            animation-duration: 14s;
        }

        .shape:nth-child(2) {
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(245, 230, 211, 0.08), transparent);
            top: 60%; left: 70%;
            animation-duration: 16s;
            animation-delay: 3s;
        }

        @keyframes float-orb {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(30px, -40px) scale(1.1); }
            66% { transform: translate(-40px, 20px) scale(0.9); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .users-card { padding: 2rem 1.5rem; }
            .users-card h2 { font-size: 1.5rem; }
            .table-responsive { padding: 1rem; }
        }
    </style>
</head>
<body>
<div class="floating-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="/"><i class="fas fa-train"></i> WaygonWay</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/admin-dashboard">Admin Dashboard</a>
            <a class="btn btn-primary" href="/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="users-card">
        <h2><i class="fas fa-users"></i> User Management</h2>
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
                        <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
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
                        <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
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
