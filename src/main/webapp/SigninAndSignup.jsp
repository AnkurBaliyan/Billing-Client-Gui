<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.util.List"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.sparktg.dboperation.ClientOperation"%>
<%@ page import = "com.sparktg.dboperation.UserOperation"%>
<%@ page import = "com.sparktg.contracts.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="js/script.js" type="text/javascript"></script>
<style type="text/css">
</style>
</head>
<body>
<%
Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.MONTH, -1);
int lastDateOfLastMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
int lastMonth = calendar.get(Calendar.MONTH)+1; //months start at 0, not 1.
int year = calendar.get(Calendar.YEAR);
%>
    <div style="position:static;" class="w3-top ">
        <div class="w3-bar w3-blue-grey w3-left-align">
            <a href="index.jsp" class="w3-bar-item w3-button w3-teal"><i class="fa fa-search w3-margin-right"></i>Search</a>
            <div class="w3-dropdown-hover w3-hide-small" >
                <a class="w3-button" style="width:110%"><i class="fa fa-list"></i>Client List</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal">
                    <a href="ClientListByMonth.jsp?currentPage=1&from=<%=new SimpleDateFormat("yyyy-MM-01").format(new Date()) %>&to=<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" class="w3-bar-item w3-button">This Month Client</a>
                    <a href="ClientListByMonth.jsp?currentPage=1&from=<%=new SimpleDateFormat(year+"-"+lastMonth+"-01").format(new Date()) %>&to=<%=new SimpleDateFormat(year+"-"+lastMonth+"-"+lastDateOfLastMonth).format(new Date()) %>" class="w3-bar-item w3-button" >Last Month Client</a>
                    <a href="ClientListByMonth.jsp?currentPage=1&from=start&to=<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>" class="w3-bar-item w3-button" >All Client</a>
                </div>
            </div>
            <div class="w3-dropdown-hover w3-hide-small" >
                <a class="w3-button" style="width:150%"><i class="fa fa-handshake-o"></i>Help</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal">
                    <a style="text-decoration:none" href="https://services.gst.gov.in/services/searchtp" class="w3-bar-item w3-button" target="_blank">Check GST</a>
                    <a style="text-decoration:none" href="http://192.168.1.100:8182/Payment/AddPaymentDetails.jsp" class="w3-bar-item w3-button" target="_blank">Add Payment Details</a>
                </div>
            </div>
            <div class="w3-dropdown-hover w3-hide-small w3-teal" style="float:right">
                <a href="AddServiceId.jsp"class="w3-button w3-teal" id="addDetails"><i class="fa fa-user-circle"></i>Add &amp Update Details</a>
            </div>
        </div>
    </div>
    <div style=" padding-bottom:3%;">
        <table align="center" style="width:60%" >
            <tr>
            <td align="center" >
            <img src="images/sparktgLogo.png">
            </td>
            </tr>
        </table>
    </div>
    <center>
    <div id="signinQuote">
        <h3><span style="color:#0C7FEB">Please sign in to add client details</span></h3>
    </div>
    </center>
    <div id="UserLogin">
        <form name="LoginForm" method="post" onsubmit="return validateLoginForm()">
            <br><label><b>Email :</b><br><input type="email" name="email" style="width:100%" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" title="Enter valid email." autofocus></label><br>
            <label><b>Password :</b><a style="color: blue;background-color: Transparent;cursor:pointer;float:right" onclick="forgotPassword()"> Forgot Password?</a><br><input type="password" name="password" style="width:100%"></label><br>
            <center><br><label><input type="submit" value="login" style="font-size:15px;cursor:pointer;width:100px;height:40px;background-color: #0C7FEB;border: outset;color:white;"></label></center>
        </form>
    </div>
    <center>
    <div id="signup">
        <h4 >Do not have account?<button  style="color: blue;background-color: Transparent;border:none;width:50%;font-size:20px;cursor:pointer;" onclick="register()"> Create an account.</button></h4>
    </div>
    </center>
    <%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    if(email != null && password != null) {
        User user = UserOperation.userLogin(email, password);
        if (user.getEmail() == null || user.getPassword() == null) {%>
            <script>
                alert("User name or password is incorrect");
            </script>
        <%}	else {
            session.setAttribute("email", email);
            session.setAttribute("password", password);
            if (request.getParameter("svc_id")!=null){
                response.sendRedirect("AddBillingDetails.jsp?svc_id="+request.getParameter("svc_id"));
            } else {
                response.sendRedirect("AddServiceId.jsp");
            }
        }
    }
    %>
    <div  id="UserRegistration">
        <form name="RegistrationForm" action="UserRegistration.jsp" method="post" onsubmit="return validateRegistrationForm()">
            <fieldset>
                <legend><span style="color:teal"><b>New Registration</b></span></legend>
                <label><b>Name :</b><input type="text" name="name"  style="width:100%" autofocus ></label><br>
                <label><b>Email :</b><input type="email" name="email" style="width:100%" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" title="Enter valid email." ></label><br>
                <label><b>Password :</b><input type="password" name="password" style="width:100%"></label><br>
            </fieldset><br>
            <center><label><input type="submit" value="Register"style="font-size:15px;cursor:pointer;width:100px;height:40px;background-color: #0C7FEB;border: outset;"></label></center>
        </form>
    </div>
    <center>
    <div id="signin" style="padding-top: .2%;">
        <h4>Already have an account?<button  style="color: blue;background-color: Transparent;border:none;cursor:pointer;" onclick="signin()">Sign In.</button></h4>
    </div>
    </center>
     <center>
    <div id="forgotPassword" style="width:300px;border:outset;">
        <form name="ForgotPasswordForm"method="post" onsubmit="return validateForgotPasswordForm()">
            <center><div style="padding-top:20px;"><b>Enter your registered email address.</b></div></center>
            <center><div style="padding-top:10px;padding-bottom:10px"><input type="email" name="check_email" placeholder="Enter your email address" style="width:250px"></div></center>
            <center><div style="padding-top:10px;padding-bottom:20px;"><b><input type="submit" value="Reset Password" style="width:250px;height:30px;background-color:green;color:white;cursor:pointer"></b></div></center>
        </form>
    </div>
    </center>
    <%
    String checkEmail = request.getParameter("check_email");
    if(checkEmail != null) {
        User user = UserOperation.getUser(checkEmail);
        if(user.getEmail() == null) {%>
            <script type="text/javascript">
                document.getElementById("signin").style.display = "none";
                document.getElementById("signup").style.display = "none";
                document.getElementById("UserLogin").style.display = "none";
                document.getElementById("UserRegistration").style.display = "none";
                document.getElementById("signinQuote").style.display = "none";
                document.getElementById("forgotPassword").style.display = "block";
                document.getElementById("addDetails").style.display = "block";
                alert("This email is not registered. Please try again with valid email.");
            </script>
        <%} else {
            response.sendRedirect("ResetPassword.jsp?email="+checkEmail);
        }
    }
    %>
</body>
</html>