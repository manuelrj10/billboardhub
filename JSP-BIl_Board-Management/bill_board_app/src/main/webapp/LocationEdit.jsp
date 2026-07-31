<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mvc.beans.LocationBean" %>
<%@ page import="mvc.dao.LocationDAO" %>
<%
    String userName = (String) session.getAttribute("username");
    if (userName == null) {
        userName = "Admin";
    }

    int locId = Integer.parseInt(request.getParameter("caId"));
    LocationBean location = LocationDAO.getLocationById(locId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Location - BillboardX</title>
    <!-- Modern Font & FontAwesome Icons -->
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
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
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

        /* Navigation Sidebar */
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

        /* Main Wrapper */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        /* Header Bar */
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

        /* Content Container */
        .content {
            padding: 2rem;
            max-width: 800px;
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

        /* Form Card Styling */
        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        .card-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border);
            background: #FAFAFA;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card-header h2 {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .card-header i {
            color: var(--primary);
        }

        .card-body {
            padding: 1.75rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        .input-control {
            width: 100%;
            padding: 0.75rem 1rem;
            font-size: 0.9rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            outline: none;
            transition: all 0.2s ease;
            background-color: #F8FAFC;
        }

        .input-control:focus {
            border-color: var(--primary);
            background-color: #FFFFFF;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        /* Action Buttons Row */
        .form-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.25rem;
            border-top: 1px solid var(--border);
        }

        .btn-save {
            padding: 0.75rem 1.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            color: white;
            background-color: var(--primary);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-save:hover {
            background-color: var(--primary-hover);
        }

        .btn-cancel {
            padding: 0.75rem 1.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-muted);
            background-color: #F1F5F9;
            border: 1px solid var(--border);
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-cancel:hover {
            background-color: #E2E8F0;
            color: var(--text-dark);
        }

        /* Mobile Layout Adjustments */
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
        }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
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
            <!-- Breadcrumbs Trail -->
            <div class="breadcrumbs">
                <a href="AdminHome.jsp">Dashboard</a>
                <i class="fa-solid fa-chevron-right"></i>
                <a href="Setting.jsp">System Settings</a>
                <i class="fa-solid fa-chevron-right"></i>
                <a href="BillLocation.jsp">Locations</a>
                <i class="fa-solid fa-chevron-right"></i>
                <span>Edit Location</span>
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

        <!-- Main Content -->
        <main class="content">
            <div class="header-section">
                <h1 class="page-title">Edit Location Details</h1>
                <p class="page-subtitle">Update physical billboard region specifications and address attributes.</p>
            </div>

            <!-- Edit Location Form Card -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-pen-to-square"></i>
                    <h2>Update Location Entry #<%= location.getLocationID() %></h2>
                </div>

                <div class="card-body">
                    <form action="LocationUpdateAction.jsp" method="post">
                        <!-- Hidden Field to Pass ID -->
                        <input type="hidden" name="locId" value="<%= location.getLocationID() %>" />

                        <div class="form-group">
                            <label for="locName">Location Name</label>
                            <input type="text" id="locName" name="locName" class="input-control" value="<%= location.getLocationName() %>" required />
                        </div>

                        <div class="form-group">
                            <label for="locAddress">Location Address</label>
                            <input type="text" id="locAddress" name="locAddress" class="input-control" value="<%= location.getLocationAddress() %>" required />
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-save">
                                <i class="fa-solid fa-check"></i> Save Changes
                            </button>
                            <a href="BillLocation.jsp" class="btn-cancel">
                                <i class="fa-solid fa-xmark"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

</body>
</html>