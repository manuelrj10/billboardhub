<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mvc.beans.LoginBean" %>
<%@ page import="mvc.dao.LoginDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%  
String username=request.getParameter("username");
String password=request.getParameter("password");
String user="";
String role="";
LoginBean login =new LoginBean();
login.setUsername(username);
login.setPassword(password);
LoginBean log=LoginDAO.checkLogin(login);
session.setAttribute("username",log.getUsername());

if(log.getRole().equalsIgnoreCase("admin")){
	response.sendRedirect("Admin.jsp");
}
else if(log.getRole().equalsIgnoreCase("inspector")){
	response.sendRedirect("Inspector.jsp");
}
else{
	response.sendRedirect("Error.jsp");
}

%>
    

</body>
</html>