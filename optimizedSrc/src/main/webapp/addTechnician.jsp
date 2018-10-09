<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <center><h3><span style="color:#0795d1">Add Technician</span></h3></center>
    </div>
    <div style="border:outset;background-color:#F4F6F6;margin-left:30%;margin-right:30%">
        <form name="TechnicianDetailsForm" method="Post" onsubmit="return validateTechnicianDetailsForm()">
            <fieldset>
                <legend><span style="color:#0795d1"><b>Technician Information</b></span></legend>
                <label><b>Id:</b><br><input type="number" name="technician_id" placeholder="Enter Technician Id"  style="width:100%;" autofocus /></label><br>
                <label><b>Name :</b><br><input type="text" name="technician_name" placeholder="Enter Technician Name" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Remove special character from starting."/></label><br>
                <label><b>Number:</b><br><input type="number" name="technician_number" placeholder="Enter 10 Digit Mobile Number" onKeyPress="if(this.value.length==10) return false;" style="width:100%;" /></label><br>
            </fieldset><br>
                <center><input type="submit" value="Save" style="height:35px;color:#0795d1;cursor:pointer;"/></center>
        </form>
    </div>
    <%
    String technicianId = request.getParameter("technician_id");
    String technicianName = request.getParameter("technician_name");
    String technicianNumber = request.getParameter("technician_number");
    if((technicianId != null && technicianId != "") && (technicianName != null && technicianName != "") && (technicianNumber != null && technicianNumber != "" )) {
        Technician technician = new Technician();
        technician.setTechnicianId(Integer.parseInt(technicianId));
        technician.setTechnicianName(technicianName);
        technician.setTechnicianNumber(technicianNumber);
        int status = TechnicianOperation.insertTechnician(technician);%>
        <script>
        <%if (status > 0) {%>
            alert("Technician details have been saved.");
            location = "technician.jsp?searchPage=1&technician_identity=<%=technicianId%>";
        <%} else {%>
            alert("Technician id already exist.");
        <%}%>
        </script>
    <%}%>
</body>
</html>