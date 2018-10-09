<%@ page import = "com.sparktg.dboperation.SiteOperation"%>
<%@ page import = "com.sparktg.contracts.Site"%>
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
    if (!request.getParameter("id").matches("[0-9]+") || request.getParameter("id").length() > 10) { %>
        <center><h4 style="color:#0795d1">NO Site Found.</h4></center>
    <% return;}
    int siteId = Integer.parseInt(request.getParameter("id"));
    List<Site> list = SiteOperation.getSite(null,Integer.parseInt(request.getParameter("id")),null);
    for(Site siteSelect : list) {
        if (siteSelect.getSiteId()==0 || siteSelect.getSiteName()==null || siteSelect.getSiteName()=="") {%>
            <center><h4 style="color:#0795d1">NO Site Found.</h4></center>
        <% return;}%>
        <div>
            <center><h3><span style="color:#0795d1">Update Site Name</span></h3></center>
        </div>
        <div style="border:outset;background-color:#F4F6F6;margin-left:30%;margin-right:30%">
            <form name="SiteForm" method="Post" onsubmit="return validateSiteForm()">
                <fieldset>
                    <legend><span style="color:#0795d1"><b>Site Information</b></span></legend>
                    <label><b>Site ID :</b><br><input type="number" name="site_id" value="<%=siteSelect.getSiteId()%>" style="width:100%;background-color:#f2f2f2" readonly/></label><br>
                    <label><b>Site Name :</b><br><input type="text" name="site_name" placeholder= "Enter Site Name"value="<%=siteSelect.getSiteName()%>" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Start name from character." /></label><br>
                </fieldset><br>
                <center>
                    <input type="submit" value="Save" style="height:35px;color:#0795d1;cursor:pointer;"/>
                    <a style="text-decoration:none" href="site.jsp?site_identity=<%=siteSelect.getSiteId()%>">
                    <input id="cancel"type="button" style="height:35px;color:#0795d1;cursor:pointer;"value="cancel"/></a><br>
                </center>
            </form>
        </div>
        <%String siteName = request.getParameter("site_name");
        if(siteName != null && siteName != "" ) {
            Site site = new Site();
            site.setSiteName(siteName);
            site.setSiteId(siteSelect.getSiteId());
            int status = SiteOperation.updateSiteName(site);%>
            <script>
            <%if (status > 0) {%>
                alert("Site mame has been updated");
            <%} else {%>
                alert("Something went wrong. Please try again.");
            <%}%>
            location = "site.jsp?site_identity=<%=siteSelect.getSiteId()%>";
            </script>
        <%}
    }%>
</body>
</html>