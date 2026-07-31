<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.beans.InspectorBean" %>
<%@ page import="mvc.dao.InspectorDAO" %>

<%
    InspectorBean ins = new InspectorBean();
    ins.setInspectorName(request.getParameter("inspectorName"));
    ins.setPhone(request.getParameter("inspectorPerson"));
    ins.setUsername(request.getParameter("inspectorUsername"));
    ins.setPassword(request.getParameter("inspectorPassword"));

    boolean ok = InspectorDAO.registerInspector(ins);

    if(ok) {
        response.sendRedirect("RegisterInspector.jsp?msg=success");
    } else {
        response.sendRedirect("RegisterInspector.jsp?msg=failed");
    }
%>