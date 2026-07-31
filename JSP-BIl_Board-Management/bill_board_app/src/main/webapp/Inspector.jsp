<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="mvc.beans.WorkAllocationBean" %>
<%@ page import="mvc.dao.WorkAllocationDAO" %>
<%@ page import="mvc.beans.LoginBean" %>
<%@ page import="mvc.dao.LoginDAO" %>
<%
    // Extract session handling & authentication
    String userName = (String) session.getAttribute("username");
    if (userName == null) {
        response.sendRedirect("login.html");
        return;
    }
    
    // Query tasks for current officer workflow
    List<WorkAllocationBean> tasks = WorkAllocationDAO.getAllAllocatedTasks();
    
    // Quick status count tallies
    int totalCount = (tasks != null) ? tasks.size() : 0;
    int completedCount = 0;
    int inProgressCount = 0;
    int issueCount = 0;
    
    if (tasks != null) {
        for (WorkAllocationBean t : tasks) {
            String st = t.getStatus();
            if ("Completed".equalsIgnoreCase(st)) completedCount++;
            else if ("Issue Reported".equalsIgnoreCase(st)) issueCount++;
            else inProgressCount++;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inspector Field Portal - BillboardX</title>
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
            
            --success: #10B981;
            --success-bg: #ECFDF5;
            --warning: #F59E0B;
            --warning-bg: #FFFBEB;
            --info: #3B82F6;
            --info-bg: #EFF6FF;
            --danger: #EF4444;
            --danger-bg: #FEF2F2;
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
            font-size: 1.2rem;
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

        .sidebar-brand .badge-role {
            font-size: 0.65rem;
            background: #1E293B;
            color: #38BDF8;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-left: auto;
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

        /* Content Area */
        .content {
            padding: 2rem;
            max-width: 1400px;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
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

        /* Metric Overview Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
        }

        .stat-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 1.25rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--shadow-sm);
        }

        .stat-info .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-top: 0.25rem;
        }

        .stat-info .stat-label {
            font-size: 0.8rem;
            color: var(--text-muted);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-icon.total { background: #EEF2FF; color: var(--primary); }
        .stat-icon.progress { background: var(--info-bg); color: var(--info); }
        .stat-icon.completed { background: var(--success-bg); color: var(--success); }
        .stat-icon.issue { background: var(--danger-bg); color: var(--danger); }

        /* Alert Banners */
        .alert {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 1.25rem;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .alert-success {
            background-color: var(--success-bg);
            color: #065F46;
            border: 1px solid #A7F3D0;
        }

        /* Card Container Styling */
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

        /* Table Styling */
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

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.25rem 0.65rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge-completed { background-color: var(--success-bg); color: #047857; }
        .badge-progress { background-color: var(--info-bg); color: #1D4ED8; }
        .badge-issue { background-color: var(--danger-bg); color: #B91C1C; }
        .badge-default { background-color: #F1F5F9; color: #475569; }

        /* Form Styling */
        .action-form {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .select-control {
            padding: 0.4rem 0.75rem;
            font-size: 0.85rem;
            border: 1px solid var(--border);
            border-radius: 6px;
            background-color: #F8FAFC;
            outline: none;
            transition: all 0.2s ease;
        }

        .select-control:focus {
            border-color: var(--primary);
            background-color: #FFFFFF;
        }

        .btn-action {
            padding: 0.4rem 0.85rem;
            font-size: 0.85rem;
            font-weight: 600;
            color: white;
            background-color: var(--primary);
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }

        .btn-action:hover {
            background-color: var(--primary-hover);
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

        /* Responsive Breakpoints */
        @media (max-width: 900px) {
            .sidebar {
                width: 70px;
            }
            .sidebar-brand span, .nav-link span, .menu-label, .badge-role {
                display: none;
            }
            .main-wrapper {
                margin-left: 70px;
            }
        }
    </style>
</head>
<body>

    <!-- Navigation Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <i class="fa-solid fa-clipboard-check"></i>
            <span>Billboard<strong>Hub</strong></span>
            <span class="badge-role">Field</span>
        </div>

        <ul class="sidebar-menu">
            <span class="menu-label">Portal Navigation</span>
            <li>
                <a href="InspectorHome.jsp" class="nav-link active">
                    <i class="fa-solid fa-list-check"></i>
                    <span>Dispatched Tasks</span>
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

    <!-- Main Workspace -->
    <div class="main-wrapper">
        
        <!-- Top Header Bar -->
        <header class="topbar">
            <div class="breadcrumbs">
                <i class="fa-solid fa-user-shield" style="color: var(--primary);"></i>
                <span>Inspector Officer Workspace</span>
            </div>

            <div class="user-profile">
                <div class="avatar">
                    <%= userName.substring(0, 1).toUpperCase() %>
                </div>
                <div class="user-info">
                    <span class="user-name"><%= userName %></span>
                    <span class="user-role">Field Inspector</span>
                </div>
            </div>
        </header>

        <!-- Main Body Content -->
        <main class="content">
            <div class="header-section">
                <div>
                    <h1 class="page-title">Welcome back, Officer <%= userName %>!</h1>
                    <p class="page-subtitle">Manage assigned billboard inspection work and declare site status reports.</p>
                </div>
            </div>

            <!-- Operational Alert Banner -->
            <%
                String msg = request.getParameter("msg");
                if("updated".equals(msg)) {
            %>
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <span>Operational task status successfully declared and logged!</span>
                </div>
            <% } %>

            <!-- Metrics Overview Row -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-label">Total Assigned</div>
                        <div class="stat-value"><%= totalCount %></div>
                    </div>
                    <div class="stat-icon total">
                        <i class="fa-solid fa-tasks"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-label">In Progress</div>
                        <div class="stat-value"><%= inProgressCount %></div>
                    </div>
                    <div class="stat-icon progress">
                        <i class="fa-solid fa-spinner"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-label">Completed</div>
                        <div class="stat-value"><%= completedCount %></div>
                    </div>
                    <div class="stat-icon completed">
                        <i class="fa-solid fa-circle-check"></i>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-label">Issues Reported</div>
                        <div class="stat-value"><%= issueCount %></div>
                    </div>
                    <div class="stat-icon issue">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                </div>
            </div>

            <!-- Dispatched Assignments Table Card -->
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-list-check"></i>
                    <h2>Dispatched Inspection Queue</h2>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Task ID</th>
                                <th>Client Tenant</th>
                                <th>Billboard Location</th>
                                <th>Assigned Date</th>
                                <th>Inspection Details</th>
                                <th>Current Status</th>
                                <th>Declare / Update Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(tasks == null || tasks.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="7">
                                        <div class="empty-state">
                                            <i class="fa-solid fa-clipboard-check"></i>
                                            <p>No work items assigned to your dashboard queue at this time.</p>
                                        </div>
                                    </td>
                                </tr>
                            <%
                                } else {
                                    for(WorkAllocationBean t : tasks) {
                                        String currentStatus = t.getStatus() != null ? t.getStatus() : "Pending";
                                        
                                        // Badge CSS class assignment
                                        String badgeClass = "badge-default";
                                        String badgeIcon = "fa-clock";
                                        if ("Completed".equalsIgnoreCase(currentStatus)) {
                                            badgeClass = "badge-completed";
                                            badgeIcon = "fa-circle-check";
                                        } else if ("In Progress".equalsIgnoreCase(currentStatus)) {
                                            badgeClass = "badge-progress";
                                            badgeIcon = "fa-spinner";
                                        } else if ("Issue Reported".equalsIgnoreCase(currentStatus)) {
                                            badgeClass = "badge-issue";
                                            badgeIcon = "fa-triangle-exclamation";
                                        }
                            %>
                                <tr>
                                    <td style="width: 90px;">
                                        <span class="id-badge">#<%= t.getWorkId() %></span>
                                    </td>
                                    <td><strong><%= t.getCompanyName() %></strong></td>
                                    <td>
                                        <i class="fa-solid fa-location-dot" style="color: var(--text-muted); margin-right: 0.25rem;"></i>
                                        <%= t.getLocationName() %>
                                    </td>
                                    <td>
                                        <i class="fa-regular fa-calendar" style="color: var(--text-muted); margin-right: 0.25rem;"></i>
                                        <%= t.getAssignedDate() %>
                                    </td>
                                    <td style="max-width: 250px;"><%= t.getWorkDescription() %></td>
                                    <td>
                                        <span class="status-badge <%= badgeClass %>">
                                            <i class="fa-solid <%= badgeIcon %>"></i>
                                            <%= currentStatus %>
                                        </span>
                                    </td>
                                    <td>
                                        <form action="UpdateTaskAction.jsp" method="post" class="action-form">
                                            <input type="hidden" name="workId" value="<%= t.getWorkId() %>" />
                                            <select name="status" class="select-control">
                                                <option value="In Progress" <%= "In Progress".equalsIgnoreCase(currentStatus) ? "selected" : "" %>>In Progress</option>
                                                <option value="Completed" <%= "Completed".equalsIgnoreCase(currentStatus) ? "selected" : "" %>>Completed</option>
                                                <option value="Issue Reported" <%= "Issue Reported".equalsIgnoreCase(currentStatus) ? "selected" : "" %>>Issue Reported</option>
                                            </select>
                                            <button type="submit" class="btn-action">
                                                <i class="fa-solid fa-floppy-disk"></i> Save
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            <% 
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>

</body>
</html>