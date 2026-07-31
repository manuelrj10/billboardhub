<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.beans.LocationBean" %>
<%@ page import="mvc.dao.LocationDAO" %>
<%
    try {
        int id = Integer.parseInt(request.getParameter("locId"));
        String name = request.getParameter("locName");
        String address = request.getParameter("locAddress");

        LocationBean location = new LocationBean();
        location.setLocationID(id);
        location.setLocationName(name);
        location.setLocationAddress(address);

        boolean updateFlag = LocationDAO.updateLocation(location);

        if (updateFlag) {
            response.sendRedirect("BillLocation.jsp");
        } else {
            response.sendRedirect("Error.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("Error.jsp");
    }
%>