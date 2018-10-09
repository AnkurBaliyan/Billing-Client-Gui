function validateSearchForm() {
    var serviceId = document.forms['SearchForm']['client_identity'].value;
    if (serviceId == null || serviceId == '') {
        alert('Please Enter Service Id or Service Name.');
        return false;
    }
} 
function validateLoginForm() {
    var email = document.forms["LoginForm"]["email"].value;
    var password = document.forms["LoginForm"]["password"].value;
    if ((email == null || email == "" )&&(password == null || password == "")) {
        alert("Please enter your email and password.");
        return false;
    } else if (email == null || email == "") {
        alert("Please enter regisetered email address.");
        return false;
    } else if (password == null || password == "") {
        alert("Please enter your password.");
        return false;
    }
} 
function signin() {
    document.getElementById('signup').style.display = 'block';
    document.getElementById('signin').style.display = 'none';
    document.getElementById('UserLogin').style.display = 'block';
    document.getElementById('UserRegistration').style.display = 'none';
}
function register() {
    document.getElementById('signin').style.display = 'block';
    document.getElementById('signup').style.display = 'none';
    document.getElementById('UserLogin').style.display = 'none';
    document.getElementById('UserRegistration').style.display = 'block';
}
function forgotPassword(){
    document.getElementById('signin').style.display = 'none';
    document.getElementById('signup').style.display = 'none';
    document.getElementById('UserLogin').style.display = 'none';
    document.getElementById('UserRegistration').style.display = 'none';
    document.getElementById('signinQuote').style.display = 'none';
    document.getElementById('forgotPassword').style.display = 'block';
    document.getElementById('addDetails').style.display = 'block';
}
function validateRegistrationForm() {
    var name = document.forms["RegistrationForm"]["name"].value;
    var email= document.forms["RegistrationForm"]["email"].value;
    var password= document.forms["RegistrationForm"]["password"].value;
    if ((name == null || name == "" ) && (email == null || email == "" ) && (password == null || password == "") ) {
        alert("All fields are mandatory !!!");
        return false;
    } else if (name == null || name == "") {
        alert("Name field are mandatory !!!");
        return false;
    } else if (email == null || email == "") {
        alert("Email field are mandatory !!!");
        return false;
    } else if (password == null || password == "") {
        alert("password field are mandatory !!!");
        return false;
    }
}
function validateForgotPasswordForm() {
    var email = document.forms["ForgotPasswordForm"]["check_email"].value;
    if (email == null || email == ""){
        alert("Please enter registered email");
        return false;
    }
}
function checkResetPassword() {
    if (document.getElementById('password').value == document.getElementById('confirm_password').value) {
        document.getElementById('message').style.color = 'green';
        document.getElementById('message').innerHTML = 'Matching';
    } else {
        document.getElementById('message').style.color = 'red';
        document.getElementById('message').innerHTML = "Not Matching";
    }
}
function validateResetPasswordForm() {
    var password = document.forms["ResetPasswordForm"]["password"].value;
    var confirmPassword=document.forms["ResetPasswordForm"]["confirm_password"].value;
    if (( password == null || password == "" ) && (confirmPassword == null || confirmPassword == "" )) {
        alert("Please enter password.");
        return false;
    } else if (password == null || password == "" ) {
        alert("Please enter new password.");
        return false;
    } else if (confirmPassword == null || confirmPassword == "") {
        alert("Please confirm password.");
        return false;
    }
}
function validateClientDetailsForm() {
    var serviceId = document.forms["ClientDetailsFrom"]["serviceId"].value;
    var serviceName = document.forms["ClientDetailsFrom"]["serviceName"].value;
    var customerName = document.forms["ClientDetailsFrom"]["customerName"].value;
    var billingAddress1 = document.forms["ClientDetailsFrom"]["billingAddress1"].value;
    var billingCity = document.forms["ClientDetailsFrom"]["billingCity"].value;
    var billingState = document.forms["ClientDetailsFrom"]["billingState"].value;
    var billingPinCode = document.forms["ClientDetailsFrom"]["billingPinCode"].value;
    var mailingAddress1 = document.forms["ClientDetailsFrom"]["mailingAddress1"].value;
    var mailingCity = document.forms["ClientDetailsFrom"]["mailingCity"].value;
    var mailingState = document.forms["ClientDetailsFrom"]["mailingState"].value;
    var mailingPinCode = document.forms["ClientDetailsFrom"]["mailingPinCode"].value;
    var ownerName = document.forms["ClientDetailsFrom"]["ownerName"].value;
    var ownerEmail = document.forms["ClientDetailsFrom"]["ownerEmail"].value;
    var ownerNumber = document.forms["ClientDetailsFrom"]["ownerNumber"].value;
    var accountsName = document.forms["ClientDetailsFrom"]["accountsName"].value;
    var accountsEmail = document.forms["ClientDetailsFrom"]["accountsEmail"].value;
    var accountsNumber = document.forms["ClientDetailsFrom"]["accountsNumber"].value;
    if ((serviceId == null || serviceId == "" ) && (serviceName == null || serviceName == "" ) && (customerName == null || customerName == "" ) && (billingAddress1 == null || billingAddress1 == "" ) && (billingCity == null || billingCity == "" ) && (billingState == null || billingState == "" ) && (billingPinCode == null || billingPinCode == "" ) && (mailingAddress1 == null || mailingAddress1 == "" ) && (mailingCity == null || mailingCity == "" ) && (mailingState == null || mailingState == "" ) && (mailingPinCode == null || mailingPinCode == "" ) && (ownerName == null || ownerName == "" ) && (ownerEmail == null || ownerEmail == "" ) && (ownerNumber == null || ownerNumber == "" ) && (accountsName == null || accountsName == "" ) && (accountsEmail == null || accountsEmail == "" ) && (accountsNumber == null || accountsNumber == "" )) {
        alert("Please provide input.");
        return false;
    } else if (serviceId == null || serviceId == "") {
        alert("Please enter serviceId.");
        return false;
    } else if (serviceName == null || serviceName == "") {
        alert("Please enter service name.");
        return false;
    } else if (customerName == null || customerName == "") {
        alert("Please enter customer name.");
        return false;
    } else if (billingAddress1 == null || billingAddress1 == "" ) {
        alert("Please enter billing address one.");
        return false;
    } else if (billingCity == null || billingCity == "" ) {
        alert("Please enter billing city name.");
        return false;
    } else if (billingState == null || billingState == "" ) {
        alert("Please enter billing state name.");
        return false;
    } else if (billingPinCode == null || billingPinCode == "" ) {
        alert("Please enter billing pin code.");
        return false;
    } else if (mailingAddress1 == null || mailingAddress1 == "" ) {
        alert("Please enter mailing address one.");
        return false;
    } else if (mailingCity == null || mailingCity == "" ) {
        alert("Please enter mailing city name.");
        return false;
    } else if (mailingState == null || mailingState == "" ) {
        alert("Please enter mailing state name.");
        return false;
    } else if (mailingPinCode == null || mailingPinCode == "" ) {
        alert("Please enter mailing pin code.");
        return false;
    } else if (ownerName == null || ownerName == "" ) {
        alert("Please enter owner name.");
        return false;
    } else if (ownerEmail == null || ownerEmail == "" ) {
        alert("Please enter owner email.");
        return false;
    } else if (ownerNumber == null || ownerNumber == "" ) {
        alert("Please enter owner number.");
        return false;
    } else if (ownerNumber.length != 10 ) {
        alert("Please enter owner's 10 digit mobile number.");
        return false;
    } else if (accountsName == null || accountsName == "" ) {
        alert("Please enter accounts person name.");
        return false;
    } else if (accountsEmail == null || accountsEmail == "" ) {
        alert("Please enter accounts email.");
        return false;
    } else if (accountsNumber == null || accountsNumber == "" ) {
        alert("Please enter accounts number.");
        return false;
    } else if (accountsNumber.length != 10 ) {
        alert("Please enter accounts contact person's 10 digit mobile number.");
        return false;
    }
}
function fillMailingAddress(sameValue) {
    if(sameValue.mailingAddress.checked == true) {
        sameValue.mailingAddress1.value = sameValue.billingAddress1.value;
        sameValue.mailingAddress2.value = sameValue.billingAddress2.value;
        sameValue.mailingCity.value = sameValue.billingCity.value;
        sameValue.mailingState.value = sameValue.billingState.value;
        sameValue.mailingPinCode.value = sameValue.billingPinCode.value;
    }
}
function fillAccountsDetails(sameValue) {
    if(sameValue.accountsDetails.checked == true) {
        sameValue.accountsName.value = sameValue.ownerName.value;
        sameValue.accountsEmail.value = sameValue.ownerEmail.value;
        sameValue.accountsNumber.value = sameValue.ownerNumber.value;
    }
}
function init() {
    document.querySelector('#files').addEventListener('change', handleFileSelect, false);
    selDiv = document.querySelector("#selectedFiles");
}
function handleFileSelect(e) {
    if(!e.target.files) return;
    selDiv.innerHTML = "";
    var files = e.target.files;
    for(var i=0; i<files.length; i++) {
        var f = files[i];
        selDiv.innerHTML += f.name + "<br/>";
    }
}
