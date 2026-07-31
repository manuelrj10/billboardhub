<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="mvc.beans.LocationBean" %>
<%@ page import="mvc.dao.LocationDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String locationName=request.getParameter("locName");
String locationAddress=request.getParameter("locAddress");

LocationBean location=new LocationBean();
location.setLocationName(locationName);
location.setLocationAddress(locationAddress);

boolean AddFlag=LocationDAO.insertLocation(location);
if(AddFlag){
	response.sendRedirect("BillLocation.jsp");
}
else{
	response.sendRedirect("Error.jsp");
}

%>

</body>
</html>