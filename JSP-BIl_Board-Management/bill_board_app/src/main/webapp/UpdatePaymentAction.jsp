<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.dao.PaymentDAO" %>
<%
    int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));
    String status = request.getParameter("status");

    boolean success = PaymentDAO.updatePayment(purchaseId, status);
    response.sendRedirect("ManagePayments.jsp?msg=" + (success ? "updated" : "error"));
%>