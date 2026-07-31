<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.beans.CustomerBean" %>
<%@ page import="mvc.dao.CustomerDAO" %>

<%
    
    String companyName = request.getParameter("companyName");
    String contactPerson = request.getParameter("contactPerson");
    String phone = request.getParameter("phone");

   
    CustomerBean customer = new CustomerBean();
    customer.setCompanyName(companyName);
    customer.setContactPerson(contactPerson);
    customer.setPhone(phone);

 
    boolean status = CustomerDAO.addCustomer(customer);

   
    if(status) {
        response.sendRedirect("ManageCustomers.jsp");
    } else {
        response.sendRedirect("ManageCustomers.jsp");
    }
%>