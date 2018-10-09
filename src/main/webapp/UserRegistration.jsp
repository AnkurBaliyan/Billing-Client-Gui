<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.sparktg.dboperation.UserOperation"%>
<%@ page import = "com.sparktg.contracts.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
</head>
<body>
<script>
    <%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    User user=new User();
    user.setName(name);
    user.setEmail(email.toLowerCase());
    user.setPassword(password);
    int status = UserOperation.userInfo(user);
    if (status > 0) {
        %>
        alert('Registration Successful.');
        location='SigninAndSignup.jsp';
    <%}	else { %>
        alert('This Email is already registered.');
        location='SigninAndSignup.jsp';
    <%}%>
</script>
</body>
</html>