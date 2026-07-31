<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.dao.WorkAllocationDAO" %>
<%
    int workId = Integer.parseInt(request.getParameter("workId"));
    String status = request.getParameter("status");

    boolean success = WorkAllocationDAO.updateTaskStatus(workId, status);
    response.sendRedirect("Inspector.jsp?msg=" + (success ? "updated" : "error"));
%>