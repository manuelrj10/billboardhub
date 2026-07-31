<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="mvc.beans.InspectorBean" %>
<%@ page import="mvc.dao.InspectorDAO" %>
<!DOCTYPE html>
<html>
<head><title>Manage Field Inspectors</title></head>
<body>
    <h1>Onboard Field Inspectors</h1>
    <a href="Admin.jsp">Back to Dashboard</a><hr/>
    <% 
        String msg = request.getParameter("msg");
        if("success".equals(msg)) out.print("<p style='color:green;'>Inspector Profile Onboarded Securely!</p>");
        if("failed".equals(msg)) out.print("<p style='color:red;'>Registration processing error occurred.</p>");
    %>
    <form action="InspectorActionControl.jsp" method="post">
        <table cellpadding="4">
            <tr><td>Full Name:</td><td><input type="text" name="inspectorName" required/></td></tr>
            <tr><td>Phone Number:</td><td><input type="text" name="phone" required/></td></tr>
            <tr><td>Account Username:</td><td><input type="text" name="username" required/></td></tr>
            <tr><td>Account Password:</td><td><input type="password" name="password" required/></td></tr>
            <tr><td colspan="2"><input type="submit" value="Register Account profile"/></td></tr>
        </table>
    </form>
    <hr/>
    <h2>Active System Inspectors</h2>
    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr><th>Inspector ID</th><th>Profile Identity Name</th><th>Contact Number</th></tr>
        </thead>
        <tbody>
            <%
                List<InspectorBean> fieldStaff = InspectorDAO.getAllInspectors();
                for(InspectorBean i : fieldStaff) {
            %>
                <tr><td><%= i.getInspectorId() %></td><td><%= i.getInspectorName() %></td><td><%= i.getPhone() %></td></tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>