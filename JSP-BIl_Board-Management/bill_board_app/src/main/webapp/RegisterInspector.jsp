<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mvc.beans.InspectorBean" %>
<%@ page import="mvc.dao.InspectorDAO" %>
<%@ page import="java.util.List" %>
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
    <title>Inspector Management - BillboardX</title>
    <!-- Google Fonts & FontAwesome Icons -->
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
            --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.1);
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

        /* Main Workspace Area */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            flex: 1;
            display: flex;
            flex-direction: column;
            min-width: 0;
        }

        /* Top Header Bar */
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

        /* Main Content Area */
        .content {
            padding: 2rem;
            max-width: 1400px;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .header-section {
            margin-bottom: 0.5rem;
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

        /* Card Container */
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
            padding: 1.5rem;
        }

        /* Form Controls Design */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.25rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-label {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 1rem;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            font-size: 0.9rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            background-color: #F8FAFC;
            color: var(--text-dark);
            outline: none;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            background-color: #FFFFFF;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .form-actions {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            margin-top: 0.5rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: #FFFFFF;
            padding: 0.75rem 1.5rem;
            font-size: 0.9rem;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
        }

        /* Data Table Styling */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 0.9rem;
        }

        .data-table th {
            background-color: #F8FAFC;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 0.875rem 1.25rem;
            border-bottom: 1px solid var(--border);
        }

        .data-table td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid var(--border);
            color: var(--text-dark);
            vertical-align: middle;
        }

        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        .data-table tbody tr:hover {
            background-color: #F1F5F9;
        }

        .id-badge {
            background: #EEF2FF;
            color: var(--primary);
            font-weight: 600;
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            font-size: 0.8rem;
            display: inline-block;
        }

        .code-pill {
            font-family: monospace;
            background-color: #F1F5F9;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            color: #475569;
            font-size: 0.85rem;
        }

        .empty-state {
            padding: 3rem 1.5rem;
            text-align: center;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 2.5rem;
            color: #CBD5E1;
            margin-bottom: 0.75rem;
        }

        /* Responsive Layout */
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
            .form-grid {
                grid-template-columns: 1fr;
            }
            .form-actions {
                grid-column: span 1;
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
                <a href="RegisterInspector.jsp" class="nav-link active">
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

    <!-- Main Content Workspace -->
    <div class="main-wrapper">
        
        <!-- Top Navigation Header -->
        <header class="topbar">
            <div class="breadcrumbs">
                <a href="AdminHome.jsp">Dashboard</a>
                <i class="fa-solid fa-chevron-right"></i>
                <span>Register Inspector</span>
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

        <!-- Page Body Content -->
        <main class="content">
            <div class="header-section">
                <h1 class="page-title">Field Inspector Management</h1>
                <p class="page-subtitle">Add new field inspectors to assign billboard site verification and maintenance work.</p>
            </div>

            <!-- Form Card Section -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-user-plus"></i>
                    <h2>Register New Inspector</h2>
                </div>
                <div class="card-body">
                    <form action="InspectorActionControl.jsp" method="post">
                        <div class="form-grid">
                            
                            <div class="form-group">
                                <label class="form-label" for="inspectorName">Inspector Full Name</label>
                                <div class="input-wrapper">
                                    <i class="fa-solid fa-user"></i>
                                    <input type="text" id="inspectorName" name="inspectorName" class="form-control" placeholder="e.g. John Doe" required />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="inspectorPerson">Phone Number</label>
                                <div class="input-wrapper">
                                    <i class="fa-solid fa-phone"></i>
                                    <input type="text" id="inspectorPerson" name="inspectorPerson" class="form-control" placeholder="e.g. +1 555-0198" required />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="inspectorUsername">Username</label>
                                <div class="input-wrapper">
                                    <i class="fa-solid fa-at"></i>
                                    <input type="text" id="inspectorUsername" name="inspectorUsername" class="form-control" placeholder="e.g. jdoe_inspector" required />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="inspectorPassword">Account Password</label>
                                <div class="input-wrapper">
                                    <i class="fa-solid fa-lock"></i>
                                    <input type="password" id="inspectorPassword" name="inspectorPassword" class="form-control" placeholder="••••••••" required />
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn-primary">
                                    <i class="fa-solid fa-user-check"></i> Register Inspector
                                </button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>

            <!-- Inspectors List Table Card -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-users-gear"></i>
                    <h2>Registered Field Inspectors</h2>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Inspector ID</th>
                                <th>Full Name</th>
                                <th>Phone Number</th>
                                <th>Username</th>
                                <th>Password</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<InspectorBean> clients = InspectorDAO.getAllInspectors();
                                if (clients != null && !clients.isEmpty()) {
                                    for(InspectorBean client : clients) {
                            %>
                            <tr>
                                <td style="width: 110px;">
                                    <span class="id-badge">#<%= client.getInspectorId() %></span>
                                </td>
                                <td>
                                    <strong><%= client.getInspectorName() %></strong>
                                </td>
                                <td>
                                    <i class="fa-solid fa-phone" style="color: var(--text-muted); font-size: 0.8rem; margin-right: 0.25rem;"></i>
                                    <%= client.getPhone() %>
                                </td>
                                <td>
                                    <span class="code-pill"><%= client.getUsername() %></span>
                                </td>
                                <td>
                                    <span class="code-pill">••••••••</span>
                                </td>
                            </tr>
                            <% 
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <i class="fa-solid fa-user-slash"></i>
                                        <p>No field inspectors currently registered in the system.</p>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>

</body>
</html>