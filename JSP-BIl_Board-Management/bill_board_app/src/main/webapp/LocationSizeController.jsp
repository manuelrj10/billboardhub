<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.beans.LocationSizeBean" %>
<%@ page import="mvc.dao.LocationSizeDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Processing Location Pricing Mapping...</title>
</head>
<body>
<%  
    try {
        // 1. Extract values directly from form input tags
        int locationId = Integer.parseInt(request.getParameter("locationId"));
        int billboardSizeId = Integer.parseInt(request.getParameter("sizeId"));
        float price = Float.parseFloat(request.getParameter("price"));
        String status = request.getParameter("status");

        // 2. Wrap incoming parameters into the matching Data Transfer Bean
        LocationSizeBean mapping = new LocationSizeBean();
        mapping.setLocation_id(locationId);
        mapping.setBillboardsize_id(billboardSizeId);
        mapping.setPrice(price);
        mapping.setStatus(status);

        // 3. Persist record using your Data Access Object layer execution logic
        boolean isSaved = LocationSizeDAO.addLocationSizeMapping(mapping);

        // 4. Redirect cleanly back to your original UI interface page using token parameters
        if(isSaved) {
            response.sendRedirect("manage_location_pricing.jsp?msg=success");
        } else {
            response.sendRedirect("manage_location_pricing.jsp?msg=failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manage_location_pricing.jsp?msg=failed");
    }
%>
</body>
</html>