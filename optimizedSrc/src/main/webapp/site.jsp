<%@ page import = "java.util.List"%>
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
}
String orderBy="id";
List<Site> list = SiteOperation.getSite(null,null,orderBy);%>
    <div style="position:fixed;" class="w3-top">
        <div class="w3-bar w3-blue-grey w3-left-align">
            <div class="w3-dropdown-hover w3-blue-grey" >
                <a href="customer.jsp" class="w3-button" style="text-decoration: none;"><i class="fa fa-list"></i>Customers</a>
            </div>
            <div class="w3-dropdown-hover">
                <a href="site.jsp" class="w3-button logoColor" style="text-decoration: none;"><i class="fa fa-list"></i>Sites</a>
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
    <%if (list.isEmpty()){%>
        <center><h4 style="color:#0795d1">NO Site Found.</h4></center>
    <%} else {%>
        <div style=" padding-right: 30px; padding-top: .5%;padding-bottom:1%">
            <form name="SearchForm" method="get" id="search" onsubmit="return validateSearchForm()">
                <table align="center" style="width:100%">
                    <tr>
                    <td align="right" style="height:35px"><b>Search:</b></td>
                    <td align="left" ><input  type='text' placeholder="Enter site id or site name" name='site_identity' <% if(null != request.getParameter("site_identity")){%>value="<%=request.getParameter("site_identity") %>"<%} %> pattern="^[a-zA-Z1-9].*" title="Remove special character from starting." style="height:35px;width:99%;" autofocus /></td>
                    <td align="left"  ><input style="height:35px;cursor:pointer;color:#0795d1;" type="submit" value="Search"></td>
                    </tr>
                </table>
            </form>
        </div>
        <center>
        <%
        if (request.getParameter("site_identity") !=  null){
            list = SiteOperation.getSite(request.getParameter("site_identity"),null,null);
            if (list.isEmpty()) {%>
            <center><div style="padding-top: .5%;"><h3><span style="color:red">Sorry for inconvenience. No record found.</span></h3></div></center>
        <% return;}
        }%>
        <div style='max-width:1100px;'>
            <table border="1" style="width:100%;border:3px solid #0795d1">
                <tr><th >Site Id</th><th >Site Name</th><th>Update</th>
                <%for (Site site : list) {%>
                    <tr>
                    <td><%=site.getSiteId() %></td><td><%=site.getSiteName()%></td><td><a href="updateSite.jsp?id=<%=site.getSiteId()%>" style="text-decoration: none; color: blue">Update</a></td>
                    </tr>
                <%}%>
            </table>
        </div>
        </center>
    <%}%>
    </div>
</body>
</html>