<%@ page import = "java.util.List"%>
<%@ page import = "com.sparktg.dboperation.TechnicianOperation"%>
<%@ page import = "com.sparktg.contracts.Technician"%>
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
String deleteTechnicianId = request.getParameter("technician_id");
String action = request.getParameter("action");
if (deleteTechnicianId != null && "delete".equals(action)) {
	TechnicianOperation.deleteTechnician(Integer.parseInt(deleteTechnicianId));
}
List<Technician> list = TechnicianOperation.getTechnician(null,null);%>
    <div style="position:fixed;" class="w3-top">
        <div class="w3-bar w3-blue-grey w3-left-align">
            <div class="w3-dropdown-hover w3-blue-grey">
                <a href="customer.jsp" class="w3-button" style="text-decoration: none;"><i class="fa fa-list"></i>Customers</a>
            </div>
            <div class="w3-dropdown-hover">
                <a href="site.jsp" class="w3-button" style="text-decoration: none;"><i class="fa fa-list"></i>Sites</a>
            </div>
            <div class="w3-dropdown-hover">
                <a href="technician.jsp" class="w3-button logoColor" style="text-decoration: none;"><i class="fa fa-list"></i>Technicians</a>
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
        <center><h4 style="color:#0795d1">NO Technician Found.</h4></center>
    <%} else {%>
        <div style=" padding-right: 30px; padding-top: .5%;padding-bottom:1%">
            <form name="SearchTechnicianForm" method="get" id="search" onsubmit="return validateSearchTechnicianForm()">
                <table align="center" style="width:100%">
                    <tr>
                    <td align="right" style="height:35px"><b>Search:</b></td>
                    <td align="left" ><input  type='text' placeholder="Enter technician id or technician name" name="technician_identity" <% if(null != request.getParameter("technician_identity")){%>value="<%=request.getParameter("technician_identity") %>"<%} %> pattern="^[a-zA-Z1-9].*" title="Remove special character from starting." style="height:35px;width:99%;" autofocus /></td>
                    <td align="left"  ><input style="height:35px;cursor:pointer;color:#0795d1;" type="submit" value="Search"></td>
                    </tr>
                </table>
            </form>
        </div>
        <center>
        <%if (request.getParameter("technician_identity") !=  null){
            list = TechnicianOperation.getTechnician(request.getParameter("technician_identity"),null);;
            if (list.isEmpty()) {%>
            <center><div style="padding-top: .5%;"><h3><span style="color:red">Sorry for inconvenience. No record found.</span></h3></div></center>
        <% return;}
        }%>
        <div style='max-width:1100px;'>
            <table border="1" style="width:100%;border:3px solid #0795d1">
                <tr><th>Technician Id</th><th>Technician Name</th><th>Technician Number</th><th>Update</th><th>Delete</th>
                <%for (Technician technician : list) {%>
                    <tr>
                    <td><%=technician.getTechnicianId() %></td><td><%=technician.getTechnicianName()%></td><td><%=technician.getTechnicianNumber()%></td>
                    <td><a href="updateTechnician.jsp?id=<%=technician.getId() %>" style="text-decoration: none; color: blue">Update</a></td>
                    <td><a href="technician.jsp?technician_id=<%=technician.getTechnicianId()%>&action=delete" onclick="return confirm('Do you want to delete this technician?');" style="text-decoration: none; color: #FC0000">Delete</a></td>
                <%}%>
            </table>
        </div>
        </center>
    <%}%>
    </div>
</body>
</html>