<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date,java.util.Calendar,java.text.SimpleDateFormat"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.sparktg.dboperation.ClientOperation"%>
<%@ page import = "com.sparktg.contracts.Client"%>
<%@ page import = "com.sparktg.contracts.User"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import = "org.apache.commons.fileupload.*"%>
<%@ page import = "org.apache.commons.fileupload.disk.*"%>
<%@ page import = "org.apache.commons.fileupload.servlet.*"%>
<%@ page import = "org.apache.commons.io.output.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="js/script.js" type="text/javascript"></script>
<script >
var selDiv = "";
document.addEventListener("DOMContentLoaded", init, false);
</script>
</head>
<body>
<%
String adderEmail = (String) session.getAttribute("email");
String password = (String) session.getAttribute("password");
Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.MONTH, -1);
int lastDateOfLastMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
int lastMonth = calendar.get(Calendar.MONTH)+1; //months start at 0, not 1.
int year = calendar.get(Calendar.YEAR);
if(adderEmail == null || password == null) {
    response.sendRedirect("SigninAndSignup.jsp");
} else{
%>
    <div style="position:fixed;" class="w3-top">
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
                <a href="index.jsp" class="w3-button w3-teal" ><i class="fa fa-list"></i>Update Client</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal" style="width:100%">
                    <a href="UserLogout.jsp"class="w3-bar-item w3-button"><i class="fa fa-sign-out"> </i>Sign out</a>
                </div>
            </div>
        </div>
    </div>
    <div style=" padding-top: 3.8%;">
        <table align="center" style="width:60%">
            <tr>
            <td align="center">
            <img src="images/sparktgLogo.png">
            </td>
            </tr>
        </table>
    </div>
    <div>
        <center><h3><span style="color:teal">Add Client Details</span></h3></center>
    </div>
    <div style="border:outset;background-color:#F4F6F6;margin-left:30%;margin-right:30%">
        <form name="ClientDetailsFrom" action="AddServiceId.jsp" method="post" onsubmit="return validateClientDetailsForm()" enctype="multipart/form-data">
            <fieldset>
                <legend><span style="color:teal"><b>Service Information</b></span></legend>
                <label><b>ServiceID:</b><br><input type="number" name="serviceId" placeholder="Enter ServiceId"  style="width:100%;" autofocus /></label><br>
                <label><b>Service Name:</b><br><input type="text" name="serviceName" placeholder="Enter Service Name" style="width:100%;" autofocus /></label><br>
                <label><b>Customer Name:</b><br><input type="text" name="customerName" placeholder="Enter Customer Name" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Enter valid customer name."/></label><br>
                <label><b>GST Number:<a target="_blank" href="https://services.gst.gov.in/services/searchtp" style="text-decoration:none;color:blue;float:right">Check GST?</a></b><br>
                <input type="text" name="gstNumber" placeholder="Enter GST Number" style="width:100%;" maxlength="15"/></label><br>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Address</b></span></legend>
                <fieldset>
                    <legend><span style="color:teal"><b>Billing Address</b></span></legend>
                    <label><b>Address LineOne:</b><br><input type="text" name="billingAddress1" placeholder="Enter Address Lineone" onKeyPress="if(this.value.length==64) return false;" style="width:100%" maxlength="64"></label><br>
                    <label><b>Address LineTwo:</b><br><input type="text" name="billingAddress2" placeholder="Enter Address Linetwo" style="width:100%"></label><br>
                    <label><b>City:</b><br><input type="text" name="billingCity" placeholder="Enter City Name" style="width:100%"></label><br>
                    <label><b>State:</b><br><input type="text" name="billingState" placeholder="Enter State Name" style="width:100%"></label><br>
                    <label><b>Pin Code:</b><br><input type="number" name="billingPinCode" placeholder="Enter Pin Code" style="width:100%" onKeyPress="if(this.value.length==6) return false;"></label>
                </fieldset>
                <input type="checkbox" name="mailingAddress" onclick="fillMailingAddress(this.form)">
                <em>Check this box if Billing Address and Mailing Address are the same.</em>
                <fieldset>
                    <legend><span style="color:teal"><b>Mailing Address</b></span></legend>
                    <label><b>Address LineOne:</b><br><input type="text" name="mailingAddress1" placeholder="Enter Address Lineone" onKeyPress="if(this.value.length==64) return false;" style="width:100%" maxlength="64"></label><br>
                    <label><b>Address LineTwo:</b><br><input type="text" name="mailingAddress2" placeholder="Enter Address Linetwo" style="width:100%"></label><br>
                    <label><b>City:</b><br><input type="text" name="mailingCity" placeholder="Enter City Name" style="width:100%"></label><br>
                    <label><b>State:</b><br><input type="text" name="mailingState" placeholder="Enter State Name" style="width:100%"></label><br>
                    <label><b>Pin Code:</b><br><input type="number" name="mailingPinCode" placeholder="Enter Pin Code" style="width:100%" onKeyPress="if(this.value.length==6) return false;"></label>
                </fieldset>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Owner's Details</b></span></legend>
                <label><b>Name:</b><br><input type="text" name="ownerName" placeholder="Enter Owner Name" style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Enter valid name" /></label><br>
                <label><b>Email:</b><br><input type="email" name="ownerEmail" placeholder="Enter Owner Email" style="width:100%;" multiple/></label><br>
                <label><b>Number:</b><br><input type="number" name="ownerNumber" placeholder="Enter 10 Digit Mobile Number" onKeyPress="if(this.value.length==10) return false;" style="width:100%;" /></label><br>
            </fieldset>
            <input type="checkbox" name="accountsDetails" onclick="fillAccountsDetails(this.form)">
            <em>Check this box if Owner's Details and Account's Details are the same.</em>
            <fieldset>
                <legend><span style="color:teal"><b>Account's Details</b></span></legend>
                <label><b>Name:</b><br><input type="text" name="accountsName" placeholder="Enter Accounts Contact Person " style="width:100%;" pattern="^[a-zA-Z1-9].*" title="Enter valid contact person name."/></label><br>
                <label><b>Email:</b><br><input type="email" name="accountsEmail" placeholder="Enter Accounts Email" style="width:100%;" multiple/></label><br>
                <label><b>Number:</b><br><input type="number" name="accountsNumber" placeholder="Enter 10 Digit Mobile Number" onKeyPress="if(this.value.length==10) return false;" style="width:100%;" /></label><br>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Add Document</b></span></legend>
                <label><input type="file" id="files" name="files" placeholder="Enter Document Link." style="width:100%;" multiple/></label>
                <div id="selectedFiles"></div>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>E-Bill</b></span></legend>
                <input type="radio" name="eBill" value="yes" >Yes<br>
                <input type="radio" name="eBill" value="no" checked>No<br>
            </fieldset>
            <fieldset>
                <legend><span style="color:teal"><b>Remark</b></span></legend>
                <label><textarea rows="4" cols="40" name="remark" ></textarea></label><br>
            </fieldset><br>
                <center><input type="submit" value="Save" style="height:35px;color:teal;cursor:pointer;"/></center>
        </form>
    </div>
    <%
    File documentFile ;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 10000 * 1024;
    String serviceId = null;
    String serviceName = null;
    String customerName = null;
    String gstNumber = null;
    String billingAddress1 = null;
    String billingAddress2 = null;
    String billingCity = null;
    String billingState = null;
    String billingPinCode = null;
    String mailingAddress1 = null;
    String mailingAddress2 = null;
    String mailingCity = null;
    String mailingState = null;
    String mailingPinCode = null;
    String ownerName = null;
    String ownerEmail = null;
    String ownerNumber = null;
    String accountsName = null;
    String accountsEmail = null;
    String accountsNumber = null;
    String documentLink = null;
    String eBill = null;
    String remark = null;
    String contentType = request.getContentType();
    if (ServletFileUpload.isMultipartContent(request) && contentType.indexOf("multipart/form-data") >= 0) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        ServletContext servletContext = this.getServletConfig().getServletContext();
        factory.setRepository(new File("/root/temp"));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax( maxFileSize );
        try {
            List<FileItem> fileItems = upload.parseRequest(request);
            Iterator<FileItem> iterator = fileItems.iterator();
            while ( iterator.hasNext () ) {
                FileItem item = iterator.next();
                if(item.isFormField ()){
                    InputStream input = item.getInputStream();
                    if(item.getFieldName().equals("serviceId")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        serviceId = new  String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("serviceName")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        serviceName = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("customerName")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        customerName = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("gstNumber")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        gstNumber = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("billingAddress1")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        billingAddress1 = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("billingAddress2")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        billingAddress2 = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("billingCity")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        billingCity = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("billingState")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        billingState = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("billingPinCode")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        billingPinCode = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("mailingAddress1")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        mailingAddress1 = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("mailingAddress2")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        mailingAddress2 = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("mailingCity")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        mailingCity = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("mailingState")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        mailingState = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("mailingPinCode")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        mailingPinCode = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("ownerName")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        ownerName = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("ownerEmail")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        ownerEmail = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("ownerNumber")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        ownerNumber = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("accountsName")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        accountsName = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("accountsEmail")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        accountsEmail = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("accountsNumber")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        accountsNumber = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("eBill")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        eBill = new String(str,"UTF8");
                    }
                    if(item.getFieldName().equals("remark")){
                        byte[] str = new byte[input.available()];
                        input.read(str);
                        remark = new String(str,"UTF8");
                    }
                } else {
                    documentLink = "/root/documents/"+customerName+"/";
                    File customerNameDir = new File(documentLink);
                    if (!customerNameDir.exists()) {
                        boolean result = false;
                        try{
                            customerNameDir.mkdir();
                            result = true;
                        } catch(SecurityException se) {}
                    }
                    String documentName = item.getName();
                    documentFile = new File( documentLink + documentName);
                    if (documentName != null && ! documentName.isEmpty()){
                        item.write( documentFile ) ;
                    }
                }
            }
        }catch(Exception ex) {}
    }
    if(adderEmail != null && serviceId != null && customerName != null && ownerName != null && ownerEmail != null && ownerNumber != null && accountsName != null && accountsEmail != null && accountsNumber != null) {
        Client client = new Client();
        client.setAdderEmail(adderEmail.toLowerCase());
        client.setServiceId(Integer.parseInt(serviceId));
        client.setServiceName(serviceName);
        client.setCustomerName(customerName);
        if(gstNumber.isEmpty()) {
            gstNumber = "NA";
        }
        client.setGSTNumber(gstNumber);
        client.setBillingAddress1(billingAddress1);
        client.setBillingAddress2(billingAddress2);
        client.setBillingCity(billingCity);
        client.setBillingState(billingState);
        client.setBillingPinCode(billingPinCode);
        client.setMailingAddress1(mailingAddress1);
        client.setMailingAddress2(mailingAddress2);
        client.setMailingCity(mailingCity);
        client.setMailingState(mailingState);
        client.setMailingPinCode(mailingPinCode);
        client.setOwnerName(ownerName);
        client.setOwnerEmail(ownerEmail.toLowerCase());
        client.setOwnerNumber(ownerNumber);
        client.setAccountsName(accountsName);
        client.setAccountsEmail(accountsEmail.toLowerCase());
        client.setAccountsNumber(accountsNumber);
        File customerNameDir = new File(documentLink);
        String docLink = null;
        if(customerNameDir.list().length>0){
            docLink="192.168.1.100/documents/"+customerName;
        }else {
            docLink="192.168.1.100/documents/"+customerName+"/null";
        }
        client.setDocumentLink(docLink);
        client.setRemark(remark);
        if(eBill.equals("yes")) {
            eBill = "true";
        }
        client.setEBill(Boolean.parseBoolean(eBill));
        int status = ClientOperation.insert(client);
        if (status > 0) {
            %>
            <script>
                alert("Client details have been saved.");
                location="AddBillingDetails.jsp?svc_id=<%=serviceId %>";
            </script>
            <%
        }
        else {
            %>
            <script>
                alert("Oops Sorry! This serviceId already exist in database");
            </script>
            <%
        }
    }
}
%>
</body>
</html>
