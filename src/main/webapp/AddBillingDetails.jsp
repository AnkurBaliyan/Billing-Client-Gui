<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding = "UTF-8"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.sparktg.dboperation.ClientOperation"%>
<%@ page import = "com.sparktg.dboperation.BillingOperation"%>
<%@ page import = "com.sparktg.contracts.Billing"%>
<%@ page import = "com.sparktg.contracts.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"/>
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script src="js/script.js"></script>
<script>
$(document).ready(function() {
    $("#date_support").datepicker();
});
</script>
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
if(adderEmail == null || password == null) {
    response.sendRedirect("SigninAndSignup.jsp?svc_id="+serviceId);
}
else {
%>
    <div style="position:fixed;" class="w3-top ">
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
                <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add Client Details</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal" style="width:100%">
                    <a href="index.jsp" class="w3-bar-item w3-button " ><i class="fa fa-list"></i>Update Client</a>
                    <a href="UserLogout.jsp"class="w3-bar-item w3-button"><i class="fa fa-sign-out"> </i>Sign out</a>
                </div>
            </div>
        </div>
    </div>
    <div style=" padding-top: 3.8%;">
        <table align="center" style="width:60%" >
            <tr>
                <td align="center">
                <img src="images/sparktgLogo.png">
                </td>
            </tr>
        </table>
    </div>
    <div>
        <center><h3><span style="color:teal">Add Billing Details</span></h3></center>
    </div>
    <div style="border:outset;background-color:#F4F6F6  ;margin-left:30%;margin-right:30%">
        <form name="BillingForm" method="post">
            <fieldset>
                <legend><span style="color:teal"><b>Service Information</b></span></legend>
                <label><b>ServiceID</b><br><input type="number" name="serviceId" value="<%=serviceId%>" style="width:100%;" readonly /></label><br>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>License Rate</b></span></legend>
                <label><b>Admin</b><br><input type="number" name="adminRate" value="0.00" step="0.01" style="width:100%;" autofocus /></label><br>
                <label><b>Agent</b><br><input type="number" name="agentRate" value="0.00" step="0.01" style="width:100%;" /></label>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>SMS Rate</b></span></legend>
                <label><input type="number" name="smsRate" value="0.20" step="0.01" style="width:100%;" readonly /></label>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Call Rate</b></span></legend>
                <fieldset>
                    <legend><b>Incoming Charges</b></legend>
                    <label>
                        <select name="incoming_charges">
                            <option value="0.00" selected>0.00</option><option value="0.10">0.10</option><option value="1.00">1.00</option>
                        </select>
                    </label>
                </fieldset>
                <fieldset>
                    <legend><b>Agent Connect</b></legend>
                    <label>
                        <select name="agent_connect">
                            <option value="0.40" selected>0.40</option><option value="0.50">0.50</option>
                        </select>
                    </label>
                </fieldset>
                <fieldset>
                    <legend><b>Customer Connect</b></legend>
                    <label>
                        <select name="customer_connect">
                            <option value="0.50" selected>0.50</option><option value="0.60">0.60</option>
                        </select>
                    </label>
                </fieldset>
                <fieldset>
                    <legend><b>CUG</b></legend>
                    <label><input type="number" name="cug" placeholder="Enter type four call rate" style="width:100%;" step="0.01" value="0.10" readonly/></label>
                </fieldset>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Other Charges</b></span></legend>
                <label><b>One time</b><br><input type="number" name="oneTimeCharges" value="0.00" step="0.01" style="width:100%;" /></label><br>
                <label><b>Monthly</b><br><input type="number" name="monthlyCharges" value="0.00" step="0.01" style="width:100%;" /></label><br>
                <label><b>Annual Recurring</b><br><input type="number" name="annualRecurring" value="0.00" step="0.01" style="width:100%;" /></label><br>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Discount</b></span></legend>
                <label><b>Free Calling Value (Per Agent)</b><br><input type="number" name="freeCallingValue" value="0.00" step="0.01" style="width:100%;" /></label><br>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Remark</b></span></legend>
                <label><textarea rows="4" cols="40" name="remark" ></textarea></label><br>
            </fieldset><br>
            <center><input type="submit" value="Save" style="height:35px;color:teal;cursor:pointer;"/>
            <a style="text-decoration:none"href="SearchServiceId.jsp?currentPage=1&searchPage=2&client_identity=<%=serviceId%>"><input type="button" value="cancel"style="height:35px;color:teal;cursor:pointer;"/></a>
            </center>
        </form>
    </div>
    <%
    String adminRate = request.getParameter("adminRate");
    String agentRate = request.getParameter("agentRate");
    String incoming = request.getParameter("incoming_charges");
    String agentConnect = request.getParameter("agent_connect");
    String customerConnect = request.getParameter("customer_connect");
    String oneTimeCharges = request.getParameter("oneTimeCharges");
    String monthlyCharges = request.getParameter("monthlyCharges");
    String annualRecurring = request.getParameter("annualRecurring");
    String freeCallingValue = request.getParameter("freeCallingValue");
    String remark = request.getParameter("remark");
    if(incoming != null && agentConnect != null && customerConnect != null) {
        Billing billing = new Billing();
        int adminRATE;
        int agentRATE;
        int smsRATE;
        int oneTimeCHARGES;
        int monthlyCHARGES;
        int annualRECURRING;
        int freeCallingVALUE;

        if(adminRate.isEmpty()) {
            adminRATE = 0;
        } else {
            adminRATE = Math.round((Float.parseFloat(adminRate))*100);
        }

        if(agentRate.isEmpty()) {
            agentRATE = 0;
        } else {
            agentRATE = Math.round((Float.parseFloat(agentRate))*100);
        }

        if(oneTimeCharges.isEmpty()) {
            oneTimeCHARGES = 0;
        } else {
            oneTimeCHARGES =Math.round((Float.parseFloat(oneTimeCharges))*100);
        }

        if(monthlyCharges.isEmpty()) {
            monthlyCHARGES = 0;
        } else {
            monthlyCHARGES = Math.round((Float.parseFloat(monthlyCharges))*100);
        }

        if(annualRecurring.isEmpty()) {
            annualRECURRING = 0;
        } else {
            annualRECURRING = Math.round((Float.parseFloat(annualRecurring))*100);
        }

        if(freeCallingValue.isEmpty()) {
            freeCallingVALUE = 0;
        } else {
            freeCallingVALUE = Math.round((Float.parseFloat(freeCallingValue))*100);
        }

        billing.setServiceId(Integer.parseInt(serviceId));
        billing.setAdminRate(adminRATE);
        billing.setAgentRate(agentRATE);
        billing.setIncoming(Math.round((Float.parseFloat(incoming))*100));
        billing.setAgentConnect(Math.round((Float.parseFloat(agentConnect))*100));
        billing.setCustomerConnect(Math.round((Float.parseFloat(customerConnect))*100));
        billing.setOneTimeCharges(oneTimeCHARGES);
        billing.setMonthlyCharges(monthlyCHARGES);
        billing.setAnnualRecurring(annualRECURRING);
        billing.setFreeCallValue(freeCallingVALUE);
        billing.setAdderEmail(adderEmail.toLowerCase());
        billing.setRemark(remark);
        int status = BillingOperation.insert(billing);
        if (status > 0) {
            %>
            <script>
                alert("Billing details have been saved.");
                location="SearchBillDetails.jsp?svc_id=<%=serviceId%>";
            </script>
            <%
        }
        else {%>
            <script>
                alert("Billing start date is incorrect or empty, please insert again.");
                location="AddBillingDetails.jsp?svc_id=<%=serviceId%>";
            </script>
            <%
        }
    }
}
%>
</body>
</html>
