<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.util.List"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "com.sparktg.dboperation.ClientOperation"%>
<%@ page import = "com.sparktg.contracts.Client"%>
<%@ page import = "com.sparktg.contracts.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Client</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css" type="text/css">
<script src="js/script.js" type="text/javascript"></script>
</head>
<body>
<%
String adderEmail = (String) session.getAttribute("email");
String password = (String) session.getAttribute("password");
String pageno = request.getParameter("currentPage");
String fromDate = null;
if(request.getParameter("from").equals("start")){
    fromDate = "2017-01-01";
} else {
    fromDate = request.getParameter("from");
}
String toDate = request.getParameter("to");
Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.MONTH, -1);
int lastDateOfLastMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
int lastMonth = calendar.get(Calendar.MONTH)+1; //months start at 0, not 1.
int year = calendar.get(Calendar.YEAR);
int pageNo = Integer.parseInt(pageno);
int startFrom = Integer.parseInt(pageno);
int total = 50;
if (startFrom == 1) {
}else {
    startFrom = startFrom - 1;
    startFrom = startFrom * total + 1;
}
int totalNumberofRecord = ClientOperation.totalNumberOfRecordByMonth(fromDate,toDate);
int totalPage = 0;
if (totalNumberofRecord % total == 0) {
    totalPage = totalNumberofRecord / total;
} else {
    totalPage = totalNumberofRecord / total + 1;
}
List<Client> list = ClientOperation.retrieveClientListByMonth(fromDate,toDate,startFrom, total);
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
                <%if(adderEmail == null || password == null ){ %>
                <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add &amp Update Details</a>
                <%}else {%>
                <a href="AddServiceId.jsp"class="w3-button w3-teal" ><i class="fa fa-user-circle"></i>Add Client Details</a>
                <div class="w3-dropdown-content w3-card-4 w3-bar-block w3-teal" style="width:100%">
                    <a href="index.jsp" class="w3-bar-item w3-button" ><i class="fa fa-list"></i>Update Client</a>
                    <a href="UserLogout.jsp"class="w3-bar-item w3-button"><i class="fa fa-sign-out"> </i>Sign out</a>
                </div>
                <%}%>
            </div>
        </div>
    </div>
    <div style=" padding-top: 3.8%;">
        <table align="center" style="width:60%">
            <tr>
            <td align="center" >
            <img src="images/sparktgLogo.png">
            </td>
            </tr>
        </table>
    </div>
    <div>
    <%if (list.isEmpty()){%>
        <center><h4 style="color:teal">NO Service Id was added in this month.</h4></center>
    <%} else {
    %>
        <center><h4 style="color:teal">ServiceID List [Total page <%=pageno%>/<%=totalPage%>]</h4></center>
        <%
        if(totalPage > 1) {
            if(pageNo >= 1 && pageNo <= totalPage) {%>
                <center><h4>
                <%if (pageNo >1 && pageNo < totalPage) {%>
                    <a href="ClientListByMonth.jsp?currentPage=<%=1 %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="previous">  &laquo; First page</button></a>
                    <a href="ClientListByMonth.jsp?currentPage=<%= --pageNo %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="previous">  &laquo; Previous Page</button></a>
                    <%int nextpageNo = pageNo+2;%>
                    <a href="ClientListByMonth.jsp?currentPage=<%= nextpageNo %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="next">Next Page &raquo;</button></a>
                    <a href="ClientListByMonth.jsp?currentPage=<%= totalPage %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="next">Last Page &raquo;</button></a>
                <%}	else if(pageNo == 1) {%>
                    <button class="disable" disabled>First page</button>
                    <button class="disable" disabled>Previous Page</button>
                    <a href="ClientListByMonth.jsp?currentPage=<%= ++pageNo %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="next">Next Page &raquo;</button></a>
                    <a href="ClientListByMonth.jsp?currentPage=<%= totalPage %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="next">Last Page &raquo;</button></a>
                <%} else if(pageNo == totalPage) {%>
                    <a href="ClientListByMonth.jsp?currentPage=<%=1 %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="previous">  &laquo; First page</button></a>
                    <a href="ClientListByMonth.jsp?currentPage=<%= --pageNo %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="previous">&laquo; Previous Page</button></a>
                    <button class="disable"  disabled>Next Page</button>
                    <button class="disable" disabled>Last Page</button>
                <%}%>
                </h4></center>
            <%} else if (pageNo > totalPage) {%>
                <center><h4 >No data found. Please go to last page.</h4>
                <a href="ClientListByMonth.jsp?currentPage=<%= totalPage %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="previous"> &laquo; Last Page</button></a>
                </center>
            <%} else if (pageNo < 1){%>
                <center><h4 >No data found. Please go to first page.</h4>
                <a href="ClientListByMonth.jsp?currentPage=<%=1 %>&from=<%=fromDate %>&to=<%=toDate %>"><button class="next"> First Page&raquo;</button></a></center>
            <%}
        }%>
        <center>
        <div style="padding-bottom:1%">
            <form name="SearchForm" action="SearchServiceId.jsp" method="post" id="search" onsubmit="return validateSearchForm()">
                <table align="center" style="width:10%%">
                    <tr>
                    <td><input type="hidden" name="currentPage" value="1"> </td>
                    <td><input type="hidden" name="searchPage" value="1"> </td>
                    <td align="left" ><input  type="text" placeholder="Enter service id or service name or customer name" name="client_identity" <% if(null!=request.getAttribute("IncorrectClientIdentity")){%>value="<%=request.getAttribute("IncorrectClientIdentity") %>"<%} %> /></td>
                    <td align="left"><input style="cursor:pointer" type="submit" value="Search"></td>
                    </tr>
                </table>
            </form>
        </div>
        </center>
        <%if(null != request.getAttribute("DataNotFound")) {%>
            <center><div><span style="color:red">"<%=request.getAttribute("DataNotFound")%>"</span></div></center>
        <%}%>
        <center>
        <div style="overflow-x:auto;">
            <table border="1" style="width:100%;border:3px solid teal">
                <tr><th >Serial No.</th><th >Service Id</th><th >Service Name</th><th >Customer Name</th><th >GST Number</th><th>Billing Address</th><th>Mailing Address</th><th>Owner Name</th><th >Owner Email</th><th>Owner Number</th><th>Account Contact Person</th><th>Accounts Email</th>
                <th>Accounts Number</th><th>E-Bill</th><th>Remark</th><th>Inserted Date</th><th>Deactivate Date</th><th>Document Link</th><th>Billing Details</th>
                <%if(adderEmail != null && password != null) {%><th>Update</th></tr><%} else {}
                    int id = startFrom;
                    if (id < total*startFrom) {
                        for (Client client : list) {
                            String eBill = null;
                            String documentLink = null;
                            if(client.getEBill() == true) {
                                eBill = "Yes";
                            } else {
                                 eBill = "No";
                            }
                            if(client.getDocumentLink().contains("//")) {
                                documentLink=client.getDocumentLink();
                            } else {
                                 documentLink="//"+client.getDocumentLink();
                            }
                            if(client.getDeactivateDate()==null || client.getDeactivateDate().isEmpty()) {%>
                            <tr>
                            <%} else { %>
                            <tr class="deativateClient">
                            <%} %>
                            <td><%=id++ %></td><td><%=client.getServiceId() %></td><td><%if(client.getServiceName() == null || client.getServiceName().isEmpty()){%><%}else{%><%=client.getServiceName()%><%}%></td><td><%=client.getCustomerName()%></td><td><%=client.getGSTNumber()%></td>
                            <td><%if (client.getBillingAddress1() == null || client.getBillingAddress1().isEmpty()){ }else{%><%=client.getBillingAddress1()%><%}%><%if (client.getBillingAddress2() == null || client.getBillingAddress2().isEmpty()){ }else{%>, <%=client.getBillingAddress2()%><%}%><%if (client.getBillingCity() == null || client.getBillingCity().isEmpty()){ }else{%>, <%=client.getBillingCity()%><%}%><%if (client.getBillingState() == null || client.getBillingState().isEmpty()){ }else{%>, <%=client.getBillingState()%><%}%><%if (client.getBillingPinCode() == null || client.getBillingPinCode().isEmpty()){ }else{%> - <%=client.getBillingPinCode()%><%}%></td>
                            <td><%if (client.getMailingAddress1() == null || client.getMailingAddress1().isEmpty()){ }else{%><%=client.getMailingAddress1()%><%}%><%if (client.getMailingAddress2() == null || client.getMailingAddress2().isEmpty()){ }else{%>, <%=client.getMailingAddress2()%><%}%><%if (client.getMailingCity() == null || client.getMailingCity().isEmpty()){ }else{%>, <%=client.getMailingCity()%><%}%><%if (client.getMailingState() == null || client.getMailingState().isEmpty()){ }else{%>, <%=client.getMailingState()%><%}%><%if (client.getMailingPinCode() == null || client.getMailingPinCode().isEmpty()){ }else{%> - <%=client.getMailingPinCode()%><%}%></td>
                            <td><%=client.getOwnerName()%></td><td><%=client.getOwnerEmail()%></td><td><%=client.getOwnerNumber()%></td><td><%=client.getAccountsName()%></td><td><%=client.getAccountsEmail()%></td><td><%=client.getAccountsNumber()%></td><td><%=eBill %></td>
                            <td><%=client.getRemark()%></td><td><%=client.getInsertedDate()%></td><td><%if(client.getDeactivateDate()==null || client.getDeactivateDate().isEmpty()) {%><%} else { %><%=client.getDeactivateDate() %><%} %></td>
                            <td><a href="<%=documentLink%>" target="_blank" style="text-decoration: none; color: blue"><%if(client.getDocumentLink().isEmpty() || (client.getDocumentLink().indexOf("/null")!= -1)){%><%}else{%>link<%}%></a></td>
                            <td><a href="SearchBillDetails.jsp?svc_id=<%=client.getServiceId() %>" style="text-decoration: none; color: blue">Bill Details</a></td>
                            <%if(adderEmail != null && password != null) {%><td><a href="UpdateClient.jsp?svc_id=<%=client.getServiceId() %>" style="text-decoration: none; color: blue">update</a></td><%} else {}%>
                            </tr>
                            <%
                        }
                    }%>
            </table>
        </div>
        <%}%>
        </center>
    </div>
</body>
</html>