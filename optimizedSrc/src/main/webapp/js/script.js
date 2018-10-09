function validateLoginForm() {
    var userLoginName = document.forms["LoginForm"]["user_login_name"].value;
    var password = document.forms["LoginForm"]["password"].value;
    if (userLoginName == null || userLoginName == "") {
        alert("Please enter user name.");
        return false;
    }
    if (password == null || password == "") {
        alert("Please enter your password.");
        return false;
    }
}

function validateSearchForm() {
    var siteId = document.forms['SearchForm']['site_identity'].value;
    if (siteId == null || siteId == '') {
        alert('Please enter site id or site name.');
        return false;
    }
}

function validateSearchTechnicianForm() {
    var technicianId = document.forms['SearchTechnicianForm']['technician_identity'].value;
    if (technicianId == null || technicianId == '') {
        alert('Please enter technician Id or technician name.');
        return false;
    }
}

function validateSiteForm() {
    var siteId = document.forms['SiteForm']['site_name'].value;
    if (siteId == null || siteId == '') {
        alert('Please enter site name.');
        return false;
    }
}

function validateCustomerDetailsForm() {
    var siteName = document.forms["CustomerDetailsForm"]["site_id"].value;
    var userName = document.forms["CustomerDetailsForm"]["user_name"].value;
    var emailId = document.forms["CustomerDetailsForm"]["email_id"].value;
    var phone = document.forms["CustomerDetailsForm"]["phone"].value;
    if (siteName == null || siteName == "") {
        alert("Please enter site name.");
        return false;
    }
    if (userName == null || userName == "") {
        alert("Please enter user name.");
        return false;
    }
    if (emailId == null || emailId == "") {
        alert("Please enter email.");
        return false;
    }
    if (phone == null || phone == "" ) {
        alert("Please enter mobile number.");
        return false;
    }
}

function validateTechnicianDetailsForm() {
    var technicianId = document.forms["TechnicianDetailsForm"]["technician_id"].value;
    var technicianName = document.forms["TechnicianDetailsForm"]["technician_name"].value;
    var technicianNumber = document.forms["TechnicianDetailsForm"]["technician_number"].value;
    if (technicianId == null || technicianId == "") {
        alert("Please enter technician id.");
        return false;
    }
    if (technicianName == null || technicianName == "") {
        alert("Please enter technician name.");
        return false;
    }
    if (technicianNumber == null || technicianNumber == "") {
        alert("Please enter technician number.");
        return false;
    }
}
