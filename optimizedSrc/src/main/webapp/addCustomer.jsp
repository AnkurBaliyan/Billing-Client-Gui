<%@ page import = "com.sparktg.dboperation.CustomerOperation"%>
<%@ page import = "com.sparktg.contracts.Customer"%>
<%@ page import = "com.sparktg.dboperation.SiteOperation"%>
<%@ page import = "com.sparktg.contracts.Site"%>
<%@ page import = "java.util.List"%>
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
}
String html = "";
String orderBy = "name";
List<Site> list = SiteOperation.getSite(null,null,orderBy);
for (Site site : list) {
    html += "<option value="+ site.getSiteId() +">"+ site.getSiteName() +"</option>";
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
    <div>
        <center><h3><span style="color:#0795d1">Add Customer</span></h3></center>
    </div>
    <div style="border:outset;background-color:#F4F6F6;margin-left:30%;margin-right:30%">
        <form name="CustomerDetailsForm" method="Post" onsubmit="return validateCustomerDetailsForm()">
            <fieldset>
                <legend><span style="color:#0795d1"><b>Customer Information</b></span></legend>
                <fieldset>
                    <legend><span style="color:#0795d1"><b>Choose Site Name</b></span></legend>
                    <label><select name="site_id"><%=html %></select></label><br>
                </fieldset>
                <fieldset>
                    <legend><span style="color:#0795d1"><b>User Information</b></span></legend>
                    <label><b>Name :</b><br><input type="text" name="user_name" placeholder="Enter User Name" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Remove special character from starting." autofocus/></label><br>
                    <label><b>Email:</b><br><input type="email" name="email_id" placeholder="Enter User Email" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Remove special character from starting." multiple/></label><br>
                    <label><b>Number:</b><br><input type="number" name="phone" placeholder="Enter 10 Digit Mobile Number" onKeyPress="if(this.value.length==10) return false;" style="width:100%;" /></label><br>
                </fieldset>
            </fieldset><br>
                <center><input type="submit" value="Save" style="height:35px;color:#0795d1;cursor:pointer;"/></center>
        </form>
    </div>
    <%
    String siteId = request.getParameter("site_id");
    String userName = request.getParameter("user_name");
    String emailId = request.getParameter("email_id");
    String phone = request.getParameter("phone");
    if((siteId != null && siteId != "") && (userName != null && userName != "") && (emailId != null && emailId != "") && (phone != null && phone != "")) {
        Customer customer = new Customer();
        customer.setSiteId(Integer.parseInt(siteId));
        customer.setUserName(userName);
        customer.setEmailId(emailId);
        customer.setPhone(phone);
        int status = CustomerOperation.insertCustomer(customer);%>
        <script>
        <%if (status > 0) {%>
            alert("Customer details have been saved.");
            location = "customer.jsp?site_identity=<%=siteId%>";
        <%} else {%>
            alert("Mobile number already exist.");
        <%}%>
        </script>
    <%}%>
</body>
</html>