<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("username");
    if (userName == null) {
        userName = "Admin";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings - BillboardX</title>
    <!-- Modern Font & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #4F46E5;
            --primary-hover: #4338CA;
            --bg-main: #F8FAFC;
            --surface: #FFFFFF;
            --text-dark: #0F172A;
            --text-muted: #64748B;
            --border: #E2E8F0;
            --sidebar-width: 260px;
            --radius: 12px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.05);
            --shadow-hover: 0 10px 15px -3px rgba(79, 70, 229, 0.1), 0 4px 6px -2px rgba(79, 70, 229, 0.05);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: var(--bg-main);
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styling */
        .sidebar {
            width: var(--sidebar-width);
            background: #0F172A;
            color: #94A3B8;
            display: flex;
            flex-direction: column;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
        }

        .sidebar-brand {
            padding: 1.5rem;
            font-size: 1.25rem;
            font-weight: 700;
            color: #FFFFFF;
            border-bottom: 1px solid #1E293B;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .sidebar-brand span {
            color: #818CF8;
        }

        .sidebar-menu {
            list-style: none;
            padding: 1rem 0.75rem;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .menu-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #475569;
            padding: 0.75rem 0.75rem 0.25rem;
            font-weight: 600;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.875rem;
            padding: 0.75rem 0.875rem;
            color: #94A3B8;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .nav-link:hover, .nav-link.active {
            background: #1E293B;
            color: #FFFFFF;
        }

        .nav-link.active i {
            color: #818CF8;
        }

        .sidebar-footer {
            padding: 1rem 0.75rem;
            border-top: 1px solid #1E293B;
        }

        .nav-link-logout {
            color: #F87171;
        }

        .nav-link-logout:hover {
            background: rgba(239, 68, 68, 0.1);
            color: #EF4444;
        }

        /* Main Content Layout */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        /* Top Bar */
        .topbar {
            height: 70px;
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
            position: sticky;
            top: 0;
            z-index: 90;
        }

        /* Breadcrumbs Navigation */
        .breadcrumbs {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            color: var(--text-muted);
        }

        .breadcrumbs a {
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.2s;
        }

        .breadcrumbs a:hover {
            color: var(--primary);
        }

        .breadcrumbs i {
            font-size: 0.75rem;
        }

        .breadcrumbs span {
            color: var(--text-dark);
            font-weight: 600;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #EEF2FF;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
        }

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .user-role {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        /* Main Body Content */
        .content {
            padding: 2rem;
            max-width: 1200px;
            width: 100%;
        }

        .header-section {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.25rem;
        }

        .page-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        /* Settings Option Cards */
        .settings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .setting-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.75rem;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-sm);
        }

        .setting-card:hover {
            transform: translateY(-4px);
            border-color: var(--primary);
            box-shadow: var(--shadow-hover);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .card-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        .icon-location { background: #E0F2FE; color: #0284C7; }
        .icon-size { background: #FEF3C7; color: #D97706; }
        .icon-pricing { background: #DCFCE7; color: #16A34A; }

        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .card-desc {
            font-size: 0.875rem;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 1.5rem;
        }

        .card-action {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--primary);
            margin-top: auto;
        }

        .setting-card:hover .card-action i {
            transform: translateX(4px);
        }

        .card-action i {
            transition: transform 0.2s ease;
        }

        /* Responsive Layout Adjustments */
        @media (max-width: 900px) {
            .sidebar {
                width: 70px;
            }
            .sidebar-brand span, .nav-link span, .menu-label {
                display: none;
            }
            .main-wrapper {
                margin-left: 70px;
            }
            .settings-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <!-- Navigation Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <i class="fa-solid fa-rectangle-ad"></i>
            <span>Billboard<strong>Hub</strong></span>
        </div>

        <ul class="sidebar-menu">
            <span class="menu-label">Main Navigation</span>
            <li>
                <a href="AdminHome.jsp" class="nav-link">
                    <i class="fa-solid fa-chart-pie"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <span class="menu-label">Management</span>
            <li>
                <a href="Setting.jsp" class="nav-link active">
                    <i class="fa-solid fa-sliders"></i>
                    <span>System Settings</span>
                </a>
            </li>
            <li>
                <a href="ManageCustomers.jsp" class="nav-link">
                    <i class="fa-solid fa-users"></i>
                    <span>Customers</span>
                </a>
            </li>
            <li>
                <a href="BookBillBoard.jsp" class="nav-link">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span>Purchases</span>
                </a>
            </li>
            <li>
                <a href="AllocateWork.jsp" class="nav-link">
                    <i class="fa-solid fa-clipboard-list"></i>
                    <span>Work Allocations</span>
                </a>
            </li>
            <li>
                <a href="ManagePayments.jsp" class="nav-link">
                    <i class="fa-solid fa-receipt"></i>
                    <span>Payment Ledger</span>
                </a>
            </li>
            <li>
                <a href="RegisterInspector.jsp" class="nav-link">
                    <i class="fa-solid fa-user-plus"></i>
                    <span>Register Inspector</span>
                </a>
            </li>
        </ul>

        <div class="sidebar-footer">
            <a href="login.html" class="nav-link nav-link-logout">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <!-- Main Wrapper -->
    <div class="main-wrapper">
        
        <!-- Header Bar -->
        <header class="topbar">
            <!-- Breadcrumbs Navigation -->
            <div class="breadcrumbs">
                <a href="AdminHome.jsp">Dashboard</a>
                <i class="fa-solid fa-chevron-right"></i>
                <span>System Settings</span>
            </div>

            <div class="user-profile">
                <div class="avatar">
                    <%= userName.substring(0, 1).toUpperCase() %>
                </div>
                <div class="user-info">
                    <span class="user-name"><%= userName %></span>
                    <span class="user-role">System Administrator</span>
                </div>
            </div>
        </header>

        <!-- Main Body -->
        <main class="content">
            <div class="header-section">
                <h1 class="page-title">System Settings</h1>
                <p class="page-subtitle">Configure geographical zones, physical billboard dimensions, and rental pricing models.</p>
            </div>

            <!-- Configuration Options Grid -->
            <div class="settings-grid">

                <!-- Setting 1: Location -->
                <a href="BillLocation.jsp" class="setting-card">
                    <div>
                        <div class="card-header">
                            <div class="card-icon icon-location">
                                <i class="fa-solid fa-location-dot"></i>
                            </div>
                            <h3 class="card-title">Billboard Locations</h3>
                        </div>
                        <p class="card-desc">Add, update, or deactivate physical advertising locations and city zones.</p>
                    </div>
                    <div class="card-action">
                        Manage Locations <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Setting 2: Size -->
                <a href="BillSize.jsp" class="setting-card">
                    <div>
                        <div class="card-header">
                            <div class="card-icon icon-size">
                                <i class="fa-solid fa-expand"></i>
                            </div>
                            <h3 class="card-title">Billboard Sizes</h3>
                        </div>
                        <p class="card-desc">Define aspect ratios, display sizes, and physical dimensions for advertising inventory.</p>
                    </div>
                    <div class="card-action">
                        Manage Sizes <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Setting 3: Location Pricing -->
                <a href="manage_location_pricing.jsp" class="setting-card">
                    <div>
                        <div class="card-header">
                            <div class="card-icon icon-pricing">
                                <i class="fa-solid fa-tags"></i>
                            </div>
                            <h3 class="card-title">Location & Pricing</h3>
                        </div>
                        <p class="card-desc">Set dynamic pricing rates, daily/monthly rental tiers based on billboard size and location popularity.</p>
                    </div>
                    <div class="card-action">
                        Manage Pricing <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

            </div>
        </main>
    </div>

</body>
</html>