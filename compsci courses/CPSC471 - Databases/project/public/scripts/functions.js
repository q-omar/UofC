var socket = io();

let userType = sessionStorage.getItem('userType');
let companyID = sessionStorage.getItem('companyID');
let employerLic = sessionStorage.getItem('employerLic');
let employeeID = sessionStorage.getItem('employeeID');

function expandForm(type){
    if (type === 'add') {
        $(".add-form").css("display", "block");
        $(".edit-form").css("display", "none");
        $(".delete-form").css("display", "none");
    }
    else if (type === 'edit') {
        $(".edit-form").css("display", "block");
        $(".add-form").css("display", "none");
        $(".delete-form").css("display", "none");
    }
    else if (type === 'delete') {
        $(".delete-form").css("display", "block");
        $(".edit-form").css("display", "none");
        $(".add-form").css("display", "none");
    }
}

socket.on('failure', function(message){
    alert(message);
});

socket.on('login details', function(loginID, password){
    alert('Registration successful!\nYour loginID is: ' + loginID + '\n' +
          'Your password is: ' + password);
    clearForm();
});

function login() {
    let loginID = document.getElementById('loginID').value;
    let password = document.getElementById('password').value;
    socket.emit('connectionLogin', {loginID: loginID, password: password});
}

socket.on('login', function (res, data) {
    if(res.message === 'success') {
        console.log(data.LicenseNum);
        sessionStorage.setItem('loggedIn', 'true');
        sessionStorage.setItem('companyID', data.CID);
        sessionStorage.setItem('employerLic', data.LicenseNum);
        sessionStorage.setItem('employeeID', data.Employee_ID);
        if (data.LicenseNum === undefined){
            sessionStorage.setItem('userType', 'employee');
            document.location.href='view.html';
        }
        else {
            sessionStorage.setItem('userType', 'employer');
            document.location.href='home.html';
        }
    }
    else {
        alert(res.message);
    }
});

function register() {
    let companyName = $("#companyName").val();
    let SIN = $("#SIN").val();
    let firstName = $("#firstName").val();
    let lastName = $("#lastName").val();
    let phoneNum = $("#phoneNum").val();
    socket.emit('register', companyName, SIN, firstName, lastName, phoneNum);
}

function editUser(){
    let userSIN = $("#user-sin-edit").val();
    let userFname = $("#user-fname-edit").val();
    let userLname = $("#user-lname-edit").val();
    let userPhoneNum = $("#user-phone-edit").val();
    socket.emit('edit user', userSIN, userFname, userLname, userPhoneNum);
    clearForm();
}

function addEmployee(){
    let userSIN = $("#user-sin").val();
    let userFname = $("#user-fname").val();
    let userLname = $("#user-lname").val();
    let userPhoneNum = $("#user-phone").val();
    let employeeMinorDeps = $("#employee-minordeps").val();
    let employeeSex = $("#employee-sex").val();
    socket.emit('add employee', userSIN, userFname, userLname, userPhoneNum, companyID, employeeMinorDeps, employeeSex);
    let currentEmployeeSIN = userSIN;
    clearForm();
    $("#salary-sin").val(currentEmployeeSIN);
}

function editEmployee(){
    let employeeSIN = $("#employee-sin-edit").val();
    let employeeMinorDeps = $("#employee-minordeps-edit").val();
    let employeeSex = $("#employee-sex-edit").val();
    socket.emit('edit employee', employeeSIN, employeeMinorDeps, employeeSex);
    clearForm();
}


function deleteEmployee() {
    let employeeSIN = $("#employee-sin-delete").val();
    socket.emit('delete employee', employeeSIN);
}

function addSalary(){
    let salarySIN = $("#salary-sin").val();
    let salaryAmount = $("#salary-amount").val();
    let salaryFrequency = $("#salary-frequency").val();
    socket.emit('add salary', salarySIN, salaryAmount, salaryFrequency, employerLic);
    clearForm();
}

function editSalary(){
    let salaryID = $("#salary-id-edit").val();
    let salaryAmount = $("#salary-amount-edit").val();
    let salaryFrequency = $("#salary-frequency-edit").val();
    socket.emit('edit salary', salaryID, salaryAmount, salaryFrequency);
    clearForm();
}

function addBonus(){
    let bonusRecID = $("#bonus-recID").val();
    let bonusAmount = $("#bonus-amount").val();
    let bonusReason = $("#bonus-reason").val();
    socket.emit('add bonus', bonusRecID, bonusAmount, bonusReason, employerLic);
    clearForm();
}

function editBonus(){
    let bonusRecID = $("#bonusID-edit").val();
    let bonusAmount = $("#bonus-amount-edit").val();
    let bonusReason = $("#bonus-reason-edit").val();
    socket.emit('edit bonus', bonusRecID, bonusAmount, bonusReason);
    clearForm();
}

function editBenefit() {
    let benefitSalaryID = $("#benefit-salaryID-edit").val();
    let benefitCCB = $("#benefit-ccb-edit").val();
    let benefitHealthcare = $("#benefit-healthcare-edit").val();
    socket.emit('edit benefit', benefitSalaryID, benefitCCB, benefitHealthcare);
    clearForm();
}

function editDeduction() {
    let deductionSalaryID = $("#deduction-salaryID-edit").val();
    let deductionTax = $("#deduction-tax-edit").val();
    let deductionEI = $("#deduction-ei-edit").val();
    let deductionUnion = $("#deduction-union-edit").val();
    socket.emit('edit deduction', deductionSalaryID, deductionTax, deductionEI, deductionUnion);
    clearForm();
}

$("#addEmployee").submit(function(e) {
    e.preventDefault();
});

$("#register").submit(function(e) {
    e.preventDefault();
});

$(function() {
    $(document).mouseup(function (e) {
        var container = $('.add-form, .edit-form, .delete-form');

        if (!container.is(e.target) // if the target of the click isn't the container...
            && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            container.fadeOut();
        }
    });
});

function clearForm() {
    $(':input')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');
}
