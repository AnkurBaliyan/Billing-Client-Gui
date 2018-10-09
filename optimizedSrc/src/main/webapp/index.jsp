<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Advant</title>
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="js/script.js"></script>
</head>
<body>
<div style=" padding-top: 5%;  padding-bottom:2%">
        <table align="center" style="width:60%">
            <tr>
            <td align="center" >
            <img src="images/sparkTG.png">
            </td>
            </tr>
        </table>
    </div>
    <div id="UserLogin">
        <form name="LoginForm" method="post" onsubmit="return validateLoginForm()">
            <br><label><b>User Name :</b><br><input type="text" name="user_login_name" style="width:98%;border:groove #0795d1;box-shadow: 2px 0px #0795d1" pattern="^[a-zA-Z1-9].*" title="Enter valid user name." autofocus></label><br>
            <label><b>Password :</b><input type="password" name="password" style="width:98%;border:groove #0795d1;box-shadow: 2px 0px #0795d1"></label><br>
            <center><br><label><input type="submit" value="Signin" style="font-size:15px;cursor:pointer;width:100px;height:40px;background-color:#0795d1;border: outset;color:white;"></label></center>
        </form>
    </div>
    <%
    String userLoginName = request.getParameter("user_login_name");
    String password = request.getParameter("password");
    if(userLoginName != null && password != null) {
        if ("admin".equals(userLoginName) && "admin".equals(password)) {
            session.setAttribute("userLoginName", userLoginName);
            session.setAttribute("password", password);
            response.sendRedirect("customer.jsp");
        } else { %>
        	<script>
               alert("Invalid Credentials.");
            </script>
          <%
       }
    }
    %>
</body>
</html>
