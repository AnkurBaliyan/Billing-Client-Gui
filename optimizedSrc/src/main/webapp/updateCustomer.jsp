<%@ page import = "com.sparktg.dboperation.CustomerOperation"%>
<%@ page import = "com.sparktg.contracts.Customer"%>
<%@ page import = "java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script>
$(function(){
    $("#includedHeader").load("header.jsp");
});
</script>
</head>
<body>
<%
String userLoginName = (String) session.getAttribute("userLoginName");
String password = (String) session.getAttribute("password");
if(userLoginName == null || password == null ){
    response.sendRedirect("index.jsp");
    return;
}%>
    <div style="position:fixed;" class="w3-top">
        <div class="w3-bar w3-blue-grey w3-left-align">
            <div class="w3-dropdown-hover">
                <a href="customer.jsp" class="w3-button logoColor" style="text-decoration: none;"><i class="fa fa-list"></i>Customers</a>
            </div>
            <div class="w3-dropdown-hover">
                <a href="site.jsp" class="w3-button" style="text-decoration: none;"><i class="fa fa-list"></i>Sites</a>
            </div>
            <div class="w3-dropdown-hover">
                <a href="technician.jsp" class="w3-button" style="text-decoration: none;"><i class="fa fa-list"></i>Technicians</a>
            </div>
            <div class="w3-dropdown-hover" style="float:right">
                <a href="addCustomer.jsp"class="w3-button logoColor" ><i class="fa fa-user-circle"></i>Add Customer</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block logoColor" style="width:100%">
                    <a href="addTechnician.jsp" class="w3-bar-item w3-button" ><i class='fa fa-user-circle'></i>Add Technician</a>
                    <a href="addSite.jsp" class="w3-bar-item w3-button" ><i class='fa fa-user-circle'></i>Add Site</a>
                    <a href="userLogout.jsp"class="w3-bar-item w3-button"><i class="fa fa-sign-out"> </i>Sign out</a>
                </div>
            </div>
        </div>
    </div>
    <div id="includedHeader"></div>
    <%
    if (!request.getParameter("phone").matches("[0-9]+") || request.getParameter("phone").length() != 10) { %>
        <center><h4 style="color:#0795d1">No Customer Found.</h4></center>
    <%return;}
    String phone = request.getParameter("phone");
    List<Customer> list = CustomerOperation.getCustomer(phone);
    for(Customer customerSelect : list) {
        if (customerSelect.getSiteName()==null || customerSelect.getSiteName()=="" || customerSelect.getUserName()==null || customerSelect.getUserName()=="" || customerSelect.getEmailId()==null || customerSelect.getEmailId() == "" || customerSelect.getPhone() == null || customerSelect.getPhone() == "") {%>
            <center><h4 style="color:#0795d1">NO Customer Found.</h4></center>
        <% return;}%>
        <div>
            <center><h3><span style="color:#0795d1">Update Customer Details</span></h3></center>
        </div>
        <div style="border:outset;background-color:#F4F6F6;margin-left:30%;margin-right:30%">
            <form name="CustomerDetailsForm" method="Post" onsubmit="return validateCustomerDetailsForm()">
                <fieldset>
                    <legend><span style="color:#0795d1"><b>Customer Information</b></span></legend>
                    <label><b>Site ID :</b><br><input type="number" name="site_id" value="<%=customerSelect.getSiteId()%>" style="width:100%;background-color:#f2f2f2" readonly/></label><br>
                    <label><b>Site Name :</b><br><input type="text" name="site_name" value="<%=customerSelect.getSiteName()%>" style="width:100%;background-color:#f2f2f2" readonly /></label><br>
                    <label><b>User Number:</b><br><input type="number" name="phone" placeholder="Enter 10 Digit Mobile Number" value="<%=customerSelect.getPhone()%>"  style="width:100%;background-color:#f2f2f2" readonly/></label><br>
                    <label><b>User Name :</b><br><input type="text" name="user_name" placeholder="Enter User Name" value="<%=customerSelect.getUserName()%>" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Remove special character from starting." autofocus/></label><br>
                    <label><b>User Email:</b><br><input type="email" name="email_id" placeholder="Enter User Email" value="<%=customerSelect.getEmailId()%>" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Remove special character from starting." multiple/></label><br>
                </fieldset><br>
                    <center>
                        <input type="submit" value="Save" style="height:35px;color:#0795d1;cursor:pointer;"/>
                        <a style="text-decoration:none" href="customer.jsp?site_identity=<%=customerSelect.getSiteId()%>">
                        <input id="cancel"type="button" style="height:35px;color:#0795d1;cursor:pointer;"value="cancel"/></a><br>
                    </center>
            </form>
        </div>
        <%String userName = request.getParameter("user_name");
        String emailId = request.getParameter("email_id");
        if(userName != null && userName != "" && emailId != null && emailId != "" ) {
            Customer customer = new Customer();
            customer.setUserName(userName);
            customer.setEmailId(emailId);
            customer.setPhone(phone);
            int status = CustomerOperation.updateCustomer(customer);%>
            <script>
            <%if (status > 0) {%>
                alert("Customer details have been updated.");
            <%} else {%>
                alert("Something went wrong. Please try again.");
            <%}%>
             location = "customer.jsp?site_identity=<%=customerSelect.getSiteId()%>";
            </script>
       <%}
    }%>
</body>
</html>