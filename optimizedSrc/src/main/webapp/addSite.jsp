<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.sparktg.dboperation.SiteOperation"%>
<%@ page import = "com.sparktg.contracts.Site"%>
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
    <div>
        <center><h3><span style="color:#0795d1">Add New Site</span></h3></center>
    </div>
    <div style="border:outset;background-color:#F4F6F6;margin-left:30%;margin-right:30%">
        <form name="SiteForm" method="Post" onsubmit="return validateSiteForm()">
            <fieldset>
                <legend><span style="color:#0795d1"><b>Site Name</b></span></legend>
                    <label><input type="text" name="site_name" placeholder="Enter site Name" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Start name from character." autofocus/></label><br>
            </fieldset><br>
                <center><input type="submit" value="Save" style="height:35px;color:#0795d1;cursor:pointer;"/></center>
        </form>
    </div>
    <%
    String siteName = request.getParameter("site_name");
    if(siteName != null && siteName != "") {
        Site site = new Site();
        site.setSiteName(siteName);
        int status = SiteOperation.insertSite(site);%>
        <script>
        <%if (status > 0) {%>
            alert("Site has been saved. Site Id(<%=status%>)");
            location = "site.jsp?site_identity=<%=siteName%>";
        <%} else {%>
            alert("Something went wrong. Please try again.");
        <%}%>
        </script>
    <%}%>
</body>
</html>