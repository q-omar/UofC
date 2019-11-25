//SETUP. Incorporate express, socket.io and mysql.
var path = require('path');
var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var port = process.env.PORT || 3000;
var mysql = require('mysql');

//Set express directory
app.use(express.static(path.join(__dirname, '/public')));

//Start server and log information
http.listen(port, function(){
	console.log('listening on *:' + port);
});

//Create database connection
var db = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'cpsc471',
	database: 'payroll'
});

//Report error if database connection fails
db.connect(function(err){
	if (err) console.log(err)
});

//All Socket.io events below
io.on('connection', function(socket){

	socket.on('connectionLogin', function (data) {
		db.query("SELECT loginID, password FROM user WHERE loginID = (?) AND password = (?)", [data.loginID, data.password], function(err, rows, fields){
			if (err) throw err;
			if(rows.length !== 0) {
				db.query("SELECT * FROM user, employer WHERE user.SIN = employer.SIN AND loginID = (?)", [data.loginID], function (err, rows2, fields) {
					if (err) throw err;
					if (rows2.length !== 0) {
						socket.emit('login', {message: 'success'}, {SIN: rows2[0].SIN, CID: rows2[0].CID, LicenseNum: rows2[0].LicenseNum});
					}
					else {
						db.query("SELECT * FROM user, employee WHERE user.SIN = employee.SIN AND loginID = (?)", [data.loginID], function (err, rows3, fields) {
							if (err) throw err;
							if (rows3.length !== 0) {
								socket.emit('login', {message: 'success'}, {SIN: rows3[0].SIN, CID: rows3[0].CID, Employee_ID: rows3[0].Employee_ID});
							}
						});
					}
				});
			}
			else {
				socket.emit('login', {message:'Login failed. Please check your loginID and password and try again'});
			}
		});
	});

	socket.on('register', function(aCompanyName, aSIN, aFirstName, aLastName, aPhoneNum){
		let CID = Math.floor((Math.random() * 1000000));
		db.query("INSERT INTO company (CID, Name) VALUES (?, ?)", [CID, aCompanyName], function(err){
			if (err) {
				if (err.errno === 1062) {
					socket.emit('failure', "An error occurred and duplicate CIDs were created. Please try again");
				}
			}
			else {
				let aPassword = '' + Math.floor((Math.random() * 1000000));
				db.query("INSERT INTO `user` (`SIN`, `First_Name`, `Last_Name`, `PhoneNum`, `CID`, `password`) VALUES (?, ?, ?, ?, ?, ?);",
					[aSIN, aFirstName, aLastName, aPhoneNum, CID, aPassword], function(err){
						if (err) {
							if (err.errno === 1062) {
								socket.emit('failure', "Error. A user with the SIN you entered already exists");
							}
						}
						else {
							db.query("INSERT INTO employer (SIN) VALUES (?)",
								[aSIN]);
							db.query("SELECT * FROM user, employer WHERE user.SIN = employer.SIN AND user.SIN = (?)", [aSIN], function (err, rows, fields) {
								socket.emit('login details', rows[0].loginID, rows[0].password);
							});
						}
					});
			}
		});
	});

	socket.on('edit company', function(aCID, aNew_Name){
		db.query("UPDATE company " +
				"SET Name = (?) " +
				"WHERE CID = (?)", [aNew_Name, aCID]);
	});

	socket.on('list companies', function(){
		db.query("SELECT * FROM company", function(result){
			socket.emit('company list', result);
		});
	});

	// socket.on('add user', function(aSIN, aFirstName, aLastName, aPhoneNum, aCID){
	// 	let aPassword = '' + Math.floor((Math.random() * 1000000));
	// 	db.query("INSERT INTO `user` (`SIN`, `First_Name`, `Last_Name`, `PhoneNum`, `CID`, `password`) VALUES (?, ?, ?, ?, ?, ?);",
	// 		[aSIN, aFirstName, aLastName, aPhoneNum, aCID, aPassword], function(err){
	// 		if (err) {
	// 			if (err.errno === 1062) {
	// 				socket.emit('failure', "Error. A user with the SIN you entered already exists");
	// 			}
	// 		}
	// 	});
	// });

	socket.on('edit user', function(aSIN, aFirstName, aLastName, aNew_Phone_Num){
		db.query("UPDATE `user` " +
			"SET `First_Name` = (?), `Last_Name` = (?), `PhoneNum` = (?)" +
			"WHERE `SIN` = (?)", [aFirstName, aLastName, aNew_Phone_Num, aSIN]);
	});

	socket.on('list users', function(){
		db.query("SELECT * FROM user", function(err, result, fields){
			socket.emit('user list', result);
		});
	});

	socket.on('add employer', function(aSIN){
		db.query("INSERT INTO employer (SIN) VALUES (?)",
			[aSIN]);
	});

	socket.on('add employee', function(aSIN, aFirstName, aLastName, aPhoneNum, aCID, aNumberDependents, aSex){
		let aPassword = '' + Math.floor((Math.random() * 1000000));
		db.query("INSERT INTO `user` (`SIN`, `First_Name`, `Last_Name`, `PhoneNum`, `CID`, `password`) VALUES (?, ?, ?, ?, ?, ?);",
			[aSIN, aFirstName, aLastName, aPhoneNum, aCID, aPassword], function(err){
				if (err) {
					if (err.errno === 1062) {
						socket.emit('failure', "Error. A user with the SIN you entered already exists");
					}
				}
				else {
					db.query("INSERT INTO `employee` (`SIN`, `NumMinorDeps`, `Sex`) VALUES (?, ?, ?)",
						[aSIN, aNumberDependents, aSex]);
				}
			});

	});

	socket.on('edit employee', function(aSIN, aNew_Number_Minor_Deps, aNew_Sex){
		db.query("UPDATE `employee` " +
			"SET `NumMinorDeps` = (?), `Sex` = (?) " +
			"WHERE SIN = (?)", [aNew_Number_Minor_Deps, aNew_Sex, aSIN], function(err){
			if (err){
				console.log(err);
			}
			else{
				let baseCCB = 1000;
				db.query("UPDATE `benefit` " +
					"SET `CCB_Amount` = (?) " +
					"WHERE `Employee_SIN` = (?)", [aNew_Number_Minor_Deps * baseCCB, aSIN]);
			}
		});
	});

	socket.on('delete employee', function(aSIN){
		db.query("DELETE from user " +
			"WHERE SIN = (?)",[aSIN]);
	});

	socket.on('list employees', function(){
		db.query("SELECT SIN, Employee_ID, NumMinorDeps, Sex FROM employee " +
			"ORDER BY SIN", function(err, result, fields){
			socket.emit('employee list', result);
		});
	});

	socket.on('add salary', function(aSIN, anAmount, aFrequency, anEmployer) {
		db.query("INSERT INTO `salary` (`Recipient_SIN`, `Employer_Lic#`, `Amount`, `Frequency`) VALUES (?, ?, ?, ?)",
			[aSIN, anEmployer, anAmount, aFrequency], function (err) {
				if (err) {
					socket.emit('failure', "Error. An error occurred while the salary was being assigned");
				} else {
					let salary_ID = 0;
					db.query("SELECT Salary_ID FROM salary " +
						"WHERE Recipient_SIN = (?)", [aSIN], function (err, result, fields) {
						if (err) {
							socket.emit('failure', "Error. An error occurred while the deductions and benefits were being calculated");
						} else {
							salary_ID = result[0].Salary_ID;
							let tax_percentage = 0;
							let ei_percentage = 0;
							if (anAmount < 50000) {
								tax_percentage = 0.05;
								ei_percentage = 0.02;
							} else if (anAmount < 100000) {
								tax_percentage = 0.07;
								ei_percentage = 0.03;
							} else if (anAmount < 150000) {
								tax_percentage = 0.10;
								ei_percentage = 0.04;
							} else {
								tax_percentage = 0.13;
								ei_percentage = 0.05;
							}
							db.query("INSERT INTO `deduction` (`Employee_SIN`, `Salary_ID`, `Tax_Amount`, `EI_Amount`, `Union_Dues`) VALUES (?, ?, ?, ?, ?)",
								[aSIN, salary_ID, anAmount * tax_percentage, anAmount * ei_percentage, 20]);
							db.query("SELECT NumMinorDeps FROM employee " +
								"WHERE SIN = (?)", [aSIN], function (err, result2, fields) {
								if (err){
									socket.emit('failure', "Error. An error occurred while the deductions and benefits were being calculated");
								}
								else {
									let numMinorDeps = result2[0].NumMinorDeps;
									let baseCCB = 1000;
									db.query("INSERT INTO `benefit` (`Employee_SIN`, `Salary_ID`, `CCB_Amount`, `Healthcare_Amount`) VALUES (?, ?, ?, ?)",
										[aSIN, salary_ID, baseCCB * numMinorDeps, 2000]);
								}
							});
						}
					});
				}
			});
	});

	socket.on('edit salary', function(aSalaryID, aNew_Amount, aNew_Frequency){
		db.query("UPDATE `salary` " +
			"SET `Amount` = (?), `Frequency` = (?) " +
			"WHERE `Salary_ID` = (?)", [aNew_Amount, aNew_Frequency, aSalaryID], function(err){
			if(err){
				console.log(err);
			}
			else {
				let tax_percentage = 0;
				let ei_percentage = 0;
				if (aNew_Amount < 50000) {
					tax_percentage = 0.05;
					ei_percentage = 0.02;
				} else if (aNew_Amount < 100000) {
					tax_percentage = 0.07;
					ei_percentage = 0.03;
				} else if (aNew_Amount < 150000) {
					tax_percentage = 0.10;
					ei_percentage = 0.04;
				} else {
					tax_percentage = 0.13;
					ei_percentage = 0.05;
				}
				db.query("UPDATE `deduction` " +
					"SET `Tax_Amount` = (?), `EI_Amount` = (?), `Union_Dues` = (?) " +
					"WHERE `Salary_ID` = (?)", [aNew_Amount * tax_percentage, aNew_Amount * ei_percentage, 20, aSalaryID]);
			}
		});

	});

	socket.on('list salaries', function(){
		db.query("SELECT * FROM salary", function(err, result, fields){
			socket.emit('salary list', result);
		});
	});

	socket.on('add bonus', function(anEmployee, anAmount, aReason, anEmployer){
		db.query("INSERT INTO `bonus` (`Employee_ID`, `Employer_Lic#`, `Reason`, `Date_Awarded`, `Amount`) VALUES (?, ?, ?, ?, ?)",
			[anEmployee, anEmployer, aReason, new Date() , anAmount], function(err){
			if (err){
				console.log(err);
				socket.emit('failure', "Error. An error occurred while the bonus was being added");
			}
			});
	});

	socket.on('edit bonus', function(aBonus, aNew_Amount, aNew_Reason){
		db.query("UPDATE `bonus` " +
			"SET `Amount` = (?), `Reason` = (?) " +
			"WHERE `Bonus_ID` = (?)", [aNew_Amount, aNew_Reason, aBonus]);
	});

	socket.on('list bonuses', function(){
		db.query("SELECT * FROM bonus", function(err, result, fields){
			socket.emit('bonus list', result);
		});
	});

	socket.on('add benefit', function(anEmployee, anAmount, aNumMinorDeps, aSalary_ID, aType){
		db.query("INSERT INTO `benefit` (`Employee_ID`, `Amount`, `#minordeps`, `Salary_ID`, `Type`) VALUES (?, ?, ?, ?, ?)",
			[anEmployee, anAmount, aNumMinorDeps, aSalary_ID, aType]);
	});

	socket.on('edit benefit', function(aSalaryID, aNew_CCBAmount, aNew_HealthcareAmount){
		db.query("UPDATE `benefit` " +
			"SET `CCB_Amount` = (?), `Healthcare_Amount` = (?) " +
			"WHERE `Salary_ID` = (?)", [aNew_CCBAmount, aNew_HealthcareAmount,aSalaryID]);
	});

	socket.on('list benefits', function(){
		db.query("SELECT Salary_ID, Employee_SIN, CCB_Amount, Healthcare_Amount FROM benefit " +
			"ORDER BY Salary_ID", function(err, result, fields){
			socket.emit('benefit list', result);
		});
	});

	socket.on('add deduction', function(anEmployee, aSalary_ID, anAmount, aType, aTaxBracket, aMembership, aPercentage){
		db.query("INSERT INTO `deduction` (`Employee_ID`, `Salary_ID`, `Amount`, `Type`, `Tax_Bracket`, `is_Member`, `Percentage`) VALUES (?, ?, ?, ?, ?, ?, ?)",
			[anEmployee, aSalary_ID, anAmount, aType, aTaxBracket, aMembership, aPercentage]);
	});

	socket.on('edit deduction', function(aSalary_ID, aNew_TaxAmount, aNew_EIAmount, aNew_UnionAmount){
		db.query("UPDATE `deduction` " +
			"SET `Tax_Amount` = (?), `EI_Amount` = (?), `Union_Dues` = (?) " +
			"WHERE `Salary_ID` = (?)", [aNew_TaxAmount, aNew_EIAmount, aNew_UnionAmount, aSalary_ID]);
	});

	socket.on('list deductions', function(){
		db.query("SELECT Salary_ID, Employee_SIN, Tax_Amount, EI_Amount, Union_Dues FROM deduction " +
			"ORDER BY Salary_ID", function(err, result, fields){
			socket.emit('deduction list', result);
		});
	});

	socket.on('list net salaries', function(){
		db.query("SELECT user.SIN, employee.Employee_ID, user.First_name, user.Last_Name, " +
			"(salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues) AS Net_Salary " +
			"FROM user, employee, salary, benefit, deduction " +
			"WHERE user.SIN = employee.SIN AND salary.Recipient_SIN = employee.SIN AND benefit.Salary_ID = salary.Salary_ID AND deduction.Salary_ID = salary.Salary_ID ",
			function(err, result, fields){
			if (err){
				console.log(err);
			}
			socket.emit('net salaries', result);
		});
	});

	socket.on('get salary stats', function(){
		db.query("SELECT SUM(salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues) AS Total_Annual_Payroll, " +
			"AVG(salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues) AS Average_Annual_Salary " +
			"FROM user, employee, salary, benefit, deduction " +
			"WHERE user.SIN = employee.SIN AND salary.Recipient_SIN = employee.SIN AND benefit.Salary_ID = salary.Salary_ID AND deduction.Salary_ID = salary.Salary_ID ",
			function(err, result, fields){
			if (err){
				console.log(err);
			}
			socket.emit('salary stats', result);
		});
	});

	socket.on('get average by sex', function(){
		db.query("SELECT employee.Sex, AVG(salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues) AS Average_Annual_Salary " +
			"FROM user, employee, salary, benefit, deduction " +
			"WHERE user.SIN = employee.SIN AND salary.Recipient_SIN = employee.SIN AND benefit.Salary_ID = salary.Salary_ID AND deduction.Salary_ID = salary.Salary_ID " +
			"GROUP BY employee.Sex",
			function(err, result, fields){
				if (err){
					console.log(err);
				}
				socket.emit('average by sex', result);
			});
	});

	socket.on('due this month', function(duration, dividor){
		db.query("SELECT user.SIN, employee.Employee_ID, user.First_Name, user.Last_Name, " +
			"(((salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues)/(?)) + SUM(bonus.Amount)) AS Due_This_Month " +
			"FROM user, employee, salary, benefit, deduction, bonus " +
			"WHERE " +
			"user.SIN = employee.SIN AND user.SIN = salary.Recipient_SIN AND user.SIN = benefit.Employee_SIN AND user.SIN = deduction.Employee_SIN AND salary.frequency = (?) " +
			"AND bonus.Employee_ID = employee.Employee_ID AND MONTH(bonus.Date_Awarded) = MONTH(curdate()) " +
			"GROUP BY user.SIN " +
			"UNION " +
			"SELECT user.SIN, employee.Employee_ID, user.First_Name, user.Last_Name, ((salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues)/(?)) AS Due_This_Month " +
			"FROM user, employee, salary, benefit, deduction, bonus " +
			"WHERE user.SIN = employee.SIN AND user.SIN = salary.Recipient_SIN AND user.SIN = benefit.Employee_SIN AND user.SIN = deduction.Employee_SIN AND salary.frequency = (?) AND employee.Employee_ID NOT IN (SELECT bonus.Employee_ID FROM bonus)"
			, [dividor, duration, dividor, duration], function(err, result, fields){
				if (err){
					console.log(err);
				}
				socket.emit('due this month', result);
			});
	});


	socket.on('view personal info', function(anEmployeeID){
		db.query("SELECT user.SIN, employee.Employee_ID, user.First_Name, user.Last_Name, user.PhoneNum, employee.NumMinorDeps, employee.Sex " +
			"FROM user, employee " +
			"WHERE user.SIN = employee.SIN AND employee.Employee_ID = (?)", [anEmployeeID], function(err, result, fields){
			socket.emit('personal', result);
		});
	});

	socket.on('view net salary', function(anEmployeeID){
		db.query("SELECT (salary.Amount + benefit.CCB_Amount + benefit.Healthcare_Amount - deduction.Tax_Amount - deduction.EI_Amount - deduction.Union_Dues) AS Net_Salary " +
			"FROM user, employee, salary, benefit, deduction " +
			"WHERE user.SIN = employee.SIN AND salary.Recipient_SIN = employee.SIN AND benefit.Salary_ID = salary.Salary_ID AND deduction.Salary_ID = salary.Salary_ID AND employee.Employee_ID = (?)" +
			"GROUP BY employee.Employee_ID", [anEmployeeID], function(err, result, fields){
			if (err){
				console.log(err);
			}
			socket.emit('net', result);
		});
	});

	socket.on('view base salary', function(anEmployeeID){
		db.query("SELECT salary.amount " +
			"FROM salary, user, employee " +
			"WHERE salary.Recipient_SIN = user.SIN AND user.SIN = employee.SIN AND employee.Employee_ID = (?)", [anEmployeeID], function(err, result, fields){
			socket.emit('base', result);
		});
	});

	socket.on('view benefits', function(anEmployeeID){
		db.query("SELECT CCB_Amount, Healthcare_Amount " +
			"FROM benefit, user, employee " +
			"WHERE benefit.Employee_SIN = user.SIN AND user.SIN = employee.SIN AND employee.Employee_ID = (?)", [anEmployeeID], function(err, result, fields){
			socket.emit('benefits', result);
		});
	});

	socket.on('view deductions', function(anEmployeeID){
		db.query("SELECT Tax_Amount, EI_Amount, Union_Dues " +
			"FROM deduction, user, employee " +
			"WHERE deduction.Employee_SIN = user.SIN AND user.SIN = employee.SIN AND employee.Employee_ID = (?)", [anEmployeeID], function(err, result, fields){
			socket.emit('deductions', result);
		});
	});

});