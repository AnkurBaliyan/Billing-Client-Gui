<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.text.SimpleDateFormat"%>
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
String adderEmail=(String) session.getAttribute("email");
String password=(String) session.getAttribute("password");
Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.MONTH, -1);
int lastDateOfLastMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
int lastMonth=calendar.get(Calendar.MONTH)+1; //months start at 0, not 1.
int year=calendar.get(Calendar.YEAR);
%>
    <div style="position:fixed;" class="w3-top ">
        <div class="w3-bar w3-blue-grey w3-left-align">
            <a href="index.jsp" class="w3-bar-item w3-button w3-teal"><i class="fa fa-search w3-margin-right"></i>Search</a>
            <div class="w3-dropdown-hover" >
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
                <%if(adderEmail == null || password == null) {%>
                <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add &amp Update Details</a>
                <%}else{%>
                <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add Client Details</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal" style="width:100%">
                    <a href="index.jsp" class="w3-bar-item w3-button" ><i class="fa fa-list"></i>Update Client</a>
                    <a href="UserLogout.jsp"class="w3-bar-item w3-button"><i class="fa fa-sign-out"> </i>Sign out</a>
                    <%} %>
                </div>
            </div>
        </div>
    </div>
    <div style=" padding-top: 3.8%;padding-bottom:3%">
        <table align="center" style="width:60%">
            <tr>
            <td align="center">
            <img src="images/sparktgLogo.png">
            </td>
            </tr>
        </table>
    </div>
    <div style=" padding-right: 30px; padding-top: .5%;">
        <form name="SearchForm" action="SearchServiceId.jsp" method="post" id="search" onsubmit="return validateSearchForm()">
            <table align="center" style="width:100%">
                <tr>
                <td align="right" style="height:35px"><b>Search:</b></td>
                <td><input type="hidden" name="currentPage" value="1"> </td>
                <td><input type="hidden" name="searchPage" value="2"> </td>
                <td align="left" ><input  type="text" placeholder="Enter service id or service name or customer name" name="client_identity" <% if(null != request.getAttribute("IncorrectClientIdentity")){%>value="<%=request.getAttribute("IncorrectClientIdentity") %>"<%} %>style="height:35px;width:99%;" autofocus /></td>
                <td align="left"  ><input style="height:35px;cursor:pointer" type="submit" value="Enter"></td>
                </tr>
            </table>
        </form>
    </div>
    <%if(null != request.getAttribute("DataNotFound")){ %>
    <center><div style="padding-top: .5%;"> <h3 ><span style="color:red">"<%=request.getAttribute("DataNotFound")%>"</span></h3></div></center>
    <%}%>
</body>
</html>