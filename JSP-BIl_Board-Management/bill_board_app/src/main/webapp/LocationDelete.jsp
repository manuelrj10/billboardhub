<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="mvc.dao.LocationDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	int locId = Integer.parseInt(request.getParameter("caId"));

	boolean deleteFlag = LocationDAO.deleteLocation(locId);

	if (deleteFlag) {
		response.sendRedirect("BillLocation.jsp");
	} else {
		response.sendRedirect("Error.jsp");
	}
	%>

</body>
</html>