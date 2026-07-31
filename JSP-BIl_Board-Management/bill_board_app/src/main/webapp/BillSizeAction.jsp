<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="mvc.beans.BillboardSizeBean"%>
<%@page import="mvc.dao.BillboardSizeDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String size = request.getParameter("billSize");
	BillboardSizeBean bSize =new BillboardSizeBean();
	bSize.setBillboard_size(size);
	boolean flagAdd=BillboardSizeDAO.insertSize(bSize);
	if(flagAdd){
		response.sendRedirect("BillSize.jsp");
	}
	else{
		response.sendRedirect("Error.jsp");
	}
	%>
</body>
</html>