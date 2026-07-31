<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("username");
    if (userName == null) {
        userName = "Admin"; // Fallback safety
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BillboardX</title>
    <!-- Modern Font & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome for Dashboard Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #4F46E5;
            --primary-light: #EEF2FF;
            --primary-hover: #4338CA;
            --bg-main: #F8FAFC;
            --surface: #FFFFFF;
            --text-dark: #0F172A;
            --text-muted: #64748B;
            --border: #E2E8F0;
            --sidebar-width: 260px;
            --radius: 12px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
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

        .welcome-badge {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-muted);
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
            background: var(--primary-light);
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

        /* Page Content Body */
        .content {
            padding: 2rem;
            max-width: 1400px;
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

        /* Action Cards Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.5rem;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-4px);
            border-color: var(--primary);
            box-shadow: var(--shadow-hover);
        }

        .card-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            margin-bottom: 1.25rem;
        }

        /* Dynamic Theme Colors for Modules */
        .card-purple .card-icon { background: #EEF2FF; color: #4F46E5; }
        .card-blue .card-icon { background: #E0F2FE; color: #0284C7; }
        .card-green .card-icon { background: #DCFCE7; color: #16A34A; }
        .card-orange .card-icon { background: #FFEDD5; color: #EA580C; }
        .card-emerald .card-icon { background: #D1FAE5; color: #059669; }
        .card-indigo .card-icon { background: #E0E7FF; color: #4338CA; }

        .card-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .card-desc {
            font-size: 0.875rem;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 1.5rem;
        }

        .card-footer-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--primary);
            margin-top: auto;
        }

        .card:hover .card-footer-link i {
            transform: translateX(4px);
        }

        .card-footer-link i {
            transition: transform 0.2s ease;
        }

        /* Mobile Responsiveness */
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
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <!-- Left Navigation Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <i class="fa-solid fa-rectangle-ad"></i>
            <span>Billboard<strong>Hub</strong></span>
        </div>

        <ul class="sidebar-menu">
            <span class="menu-label">Main Navigation</span>
            <li>
                <a href="AdminHome.jsp" class="nav-link active">
                    <i class="fa-solid fa-chart-pie"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            
            <span class="menu-label">Management</span>
            <li>
                <a href="Setting.jsp" class="nav-link">
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

    <!-- Main Section Wrapper -->
    <div class="main-wrapper">
        
        <!-- Header Bar -->
        <header class="topbar">
            <div class="welcome-badge">
                <i class="fa-regular fa-hand"></i> Welcome back to Admin Portal
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

        <!-- Main Dashboard Content -->
        <main class="content">
            <div class="header-section">
                <h1 class="page-title">Admin Control Center</h1>
                <p class="page-subtitle">Manage operations, monitoring, configurations, and customer relations.</p>
            </div>

            <!-- Action Modules Grid -->
            <div class="dashboard-grid">

                <!-- Module 1: Settings -->
                <a href="Setting.jsp" class="card card-purple">
                    <div>
                        <div class="card-icon">
                            <i class="fa-solid fa-gears"></i>
                        </div>
                        <h3 class="card-title">System Settings</h3>
                        <p class="card-desc">Configure billboard inventory, rates, sizes, and active geographic locations.</p>
                    </div>
                    <div class="card-footer-link">
                        Manage Configurations <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Module 2: Customers -->
                <a href="ManageCustomers.jsp" class="card card-blue">
                    <div>
                        <div class="card-icon">
                            <i class="fa-solid fa-address-book"></i>
                        </div>
                        <h3 class="card-title">Customer Management</h3>
                        <p class="card-desc">View registered customer profiles, account statuses, and ad histories.</p>
                    </div>
                    <div class="card-footer-link">
                        View Customers <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Module 3: Billboard Purchases -->
                <a href="BookBillBoard.jsp" class="card card-green">
                    <div>
                        <div class="card-icon">
                            <i class="fa-solid fa-rectangle-ad"></i>
                        </div>
                        <h3 class="card-title">Purchase Management</h3>
                        <p class="card-desc">Process billboard space bookings, lease periods, and availability schedules.</p>
                    </div>
                    <div class="card-footer-link">
                        Manage Bookings <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Module 4: Work Allocation -->
                <a href="AllocateWork.jsp" class="card card-orange">
                    <div>
                        <div class="card-icon">
                            <i class="fa-solid fa-list-check"></i>
                        </div>
                        <h3 class="card-title">Work Allocation</h3>
                        <p class="card-desc">Assign field maintenance, banner installations, and inspection tasks.</p>
                    </div>
                    <div class="card-footer-link">
                        Allocate Work <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Module 5: Payments -->
                <a href="ManagePayments.jsp" class="card card-emerald">
                    <div>
                        <div class="card-icon">
                            <i class="fa-solid fa-file-invoice-dollar"></i>
                        </div>
                        <h3 class="card-title">Payment Tracking Ledger</h3>
                        <p class="card-desc">Monitor transaction logs, pending invoices, and customer payment receipts.</p>
                    </div>
                    <div class="card-footer-link">
                        View Ledger <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <!-- Module 6: Register Inspector -->
                <a href="RegisterInspector.jsp" class="card card-indigo">
                    <div>
                        <div class="card-icon">
                            <i class="fa-solid fa-user-shield"></i>
                        </div>
                        <h3 class="card-title">Register Inspector</h3>
                        <p class="card-desc">Add new field inspectors to monitor and verify billboard installations.</p>
                    </div>
                    <div class="card-footer-link">
                        Add New Inspector <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

            </div>
        </main>
    </div>

</body>
</html>