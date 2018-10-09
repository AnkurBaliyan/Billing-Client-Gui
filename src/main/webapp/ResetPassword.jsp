<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.sparktg.contracts.User"%>
<%@ page import = "com.sparktg.dboperation.UserOperation"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="js/script.js" type="text/javascript"></script>
</head>
<body>
<%
String email = request.getParameter("email");
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
                <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add &amp Update Details</a>
            </div>
        </div>
    </div>
    <div style=" padding-bottom: 3%;">
        <table align="center" style="width:60%">
            <tr>
            <td align="center">
            <img src="images/sparktgLogo.png">
            </td>
            </tr>
        </table>
    </div>
    <div style="border:outset;margin-left:38%;margin-right:38%;">
        <form name="ResetPasswordForm" method="post" onsubmit="return validateResetPasswordForm()" >
            <center><div style="padding-top:20px;"><b>Reset Password.</b></div></center>
            <label><b>Email:</b><br><input type="email" name="email" value="<%=email%>"style="width:100%" readonly ></label>
            <label><b>Enter New Password:</b><br><input type="password" name="password" id="password" style="width:100%"  ></label>
            <label><b>Confirm Password:</b><br><input type="password" name="confirm_password" id="confirm_password"style="width:100%"  onkeyup="checkResetPassword();" ><br><span id="message"></span></label>
            <center><div style="padding-top:10px;padding-bottom:20px;cursor:pointer"><b><input type="submit" value="Reset Password" style="width:250px;height:30px;background-color:green;color:white" ></b></div></center>
        </form>
    </div>
    <%
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");
    if(confirmPassword != null && password != null){
        if (confirmPassword.equals(password)){
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            int status = UserOperation.resetPassword(user);
            if(status > 0){%>
                <script>
                    alert("Password reset successfully.");
                    location="AddServiceId.jsp";
                </script>
            <%} else { %>
                <script>
                    alert("Password mismatch. Please enter password again.");
                </script>
            <%}
        } else {%>
            <script>
                alert("Password mismatch. Please enter password again.");
            </script>
        <%}
    }
    %>
</body>
</html>