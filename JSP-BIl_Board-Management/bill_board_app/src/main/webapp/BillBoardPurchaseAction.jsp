<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.beans.BillboardPurchaseBean" %>
<%@ page import="mvc.beans.LocationSizeBean" %>
<%@ page import="mvc.dao.BillboardPurchaseDAO" %>
<%@ page import="mvc.dao.LocationSizeDAO" %>
<%@ page import="java.util.List" %>

<%
   
    int customerId = Integer.parseInt(request.getParameter("customerId"));
    int locationSizeId = Integer.parseInt(request.getParameter("locationSizeId"));
    String startDate = request.getParameter("startDate");
    int duration = Integer.parseInt(request.getParameter("duration"));

   
    float pricePerDay = 0.0f;
    List<LocationSizeBean> mappings = LocationSizeDAO.getAllLocationSizeMappings();
    for (LocationSizeBean m : mappings) {
        if (m.getBillboardsize_id()== locationSizeId) {
            pricePerDay = m.getPrice();
            break;
        }
    }

    // 3. Calculate absolute total booking cost
    float totalAmount = pricePerDay * duration;

    // 4. Populate Bean object variables
    BillboardPurchaseBean purchase = new BillboardPurchaseBean();
    purchase.setCustomerID(customerId);
    purchase.setLocationSizeId(locationSizeId);
    purchase.setStartDate(startDate);
    purchase.setDuration(duration);
    purchase.setAmouunt(totalAmount);

    // 5. Submit to database mapping
    boolean isBooked = BillboardPurchaseDAO.addPurchase(purchase);

    if(isBooked) {
        response.sendRedirect("BookBillBoard.jsp?msg=success");
    } else {
        response.sendRedirect("BookBillBoard.jsp?msg=failed");
    }
%>