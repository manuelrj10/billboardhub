<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.beans.WorkAllocationBean" %>
<%@ page import="mvc.dao.WorkAllocationDAO" %>

<%
    WorkAllocationBean task = new WorkAllocationBean();
    task.setInspectorId(Integer.parseInt(request.getParameter("inspectorId")));
    task.setPurchaseId(Integer.parseInt(request.getParameter("purchaseId")));
    task.setAssignedDate(request.getParameter("assignedDate"));
    task.setWorkDescription(request.getParameter("workDescription"));

    boolean ok = WorkAllocationDAO.allocateTask(task);

    if(ok) {
        response.sendRedirect("AllocateWork.jsp?msg=success");
    } else {
        response.sendRedirect("AllocateWork.jsp?msg=failed");
    }
%>