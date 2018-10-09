<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.sparktg.dboperation.BillingOperation"%>
<%@ page import = "com.sparktg.contracts.Billing"%>
<%@ page import = "com.sparktg.contracts.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css" type="text/css">
</head>
<body>
<%
String adderEmail = (String) session.getAttribute("email");
String password = (String) session.getAttribute("password");
String serviceId = request.getParameter("svc_id");
Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.MONTH, -1);
int lastDateOfLastMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
int lastMonth = calendar.get(Calendar.MONTH)+1; //months start at 0, not 1.
int year = calendar.get(Calendar.YEAR);
%>
    <div style="position:static;" class="w3-top">
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
                <%if(adderEmail == null || password == null ){ %>
                    <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add &amp Update Details</a>
                <%}else {%>
                    <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add Client Details</a>
                    <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal" style="width:100%">
                        <a href="index.jsp" class="w3-bar-item w3-button " ><i class="fa fa-list"></i>Update Client</a>
                        <a href="UserLogout.jsp"class="w3-bar-item w3-button"><i class="fa fa-sign-out"> </i>Sign out</a>
                    </div>
                <%}%>
            </div>
        </div>
    </div>
    <div style=" padding-bottom: 1%;">
        <table align="center" style="width:60%" >
            <tr>
            <td align="center" >
            <img src="images/sparktgLogo.png">
            </td>
            </tr>
        </table>
    </div>
    <div>
        <center><h3 style="color:#003300">Billing Details of Service ID : <%=serviceId %></h3></center>
    </div>
    <div style="overflow-x:auto">
        <%
        Billing billing = BillingOperation.search(Integer.parseInt(serviceId));
        if (billing.getServiceId() == 0) {%>
            <script>
            if (window.confirm("Billing details of this service id does not exist. Do you want to add bill details ?")) {
                location="AddBillingDetails.jsp?svc_id=<%=serviceId %>";
            } else {
                location="SearchServiceId.jsp?currentPage=1&searchPage=2&client_identity=<%=serviceId %>"
            }
            </script>
        <%} else {%>
            <table border="1" style="border:3px solid teal">
                <tr>
                <th>Serial No.</th><th >Service Id</th><th >Admin Rate</th><th >Agent Rate</th><th >SMS Rate</th><th>Incoming Charges</th><th>Agent Connect</th><th>Customer Connect</th><th>CUG</th>
                <th>One Time Charges</th><th>Monthly Charges</th><th>Annual Recurring</th><th>Free Calling Value (Per Agent) Discount</th><th>Remark</th><th>Payment Details</th><th>Client Details</th>
                <%if(adderEmail!=null || password!=null) {%><th>Update Details</th><%} else{}%>
                </tr>
                <tr>
                <td><%=1 %></td><td><%=billing.getServiceId() %></td><td><%=(float)(billing.getAdminRate())/100%></td><td><%=(float)(billing.getAgentRate())/100%></td><td><%=(float)(billing.getSMSRate())/100%></td><td><%=(float)(billing.getIncoming())/100%></td><td><%=(float)(billing.getAgentConnect())/100%></td>
                <td><%=(float)(billing.getCustomerConnect())/100%></td><td><%=(float)(billing.getCug())/100%></td><td><%=(float)(billing.getOneTimeCharges())/100%></td><td><%=(float)(billing.getMonthlyCharges())/100%></td><td><%=(float)(billing.getAnnualRecurring())/100%></td><td><%=(float)(billing.getFreeCallingValue())/100%></td>
                <td><%if(billing.getRemark() == null || billing.getRemark().isEmpty()){%><%}else{%><%=billing.getRemark()%><%}%></td>
                <td><a href="http://192.168.1.100:8182/Payment/SearchServiceId.jsp?page=1&service_id=<%=serviceId%>" target="_blank" style="text-decoration: none; color: blue">payment details</a></td>
                <td><a href="SearchServiceId.jsp?currentPage=1&searchPage=2&client_identity=<%=serviceId%>" style="text-decoration: none; color: blue">client details</a></td>
                <%if(adderEmail != null || password != null) {%><td><a href="UpdateBill.jsp?svc_id=<%=billing.getServiceId() %>" style="text-decoration: none; color: blue">update</a></td><%} else {}%>
                </tr>
            </table>
        <%}%>
    </div>
</body>
</html>
