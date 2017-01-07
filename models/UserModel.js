var mysql = require('mysql');
var sha1 = require('sha1');
var dbConn = require('../sqlConn');

exports.createLogin = function(user, callBack){
	console.log(user);

	var createQuery = "INSERT INTO logins (uname, passwd, email, staff_id, cust_id) VALUES (?, ?, ?, ?, ?)";

	dbConn.query(createQuery, [user.uname, user.passwd, user.email, user.staff_id, user.cust_id],
		function(err, result){
			if(err) console.log(err);
			result.user = user;
			callBack(result);
	});
}

exports.createStaffMember = function(staffMember, callBack){
	console.log("Creating Staff...");
	staffMember.passwd = sha1(staffMember.passwd);

	var insertQuery = "INSERT INTO staff (staff_fname, staff_lname, staff_type, staff_contact, branch_id)\
		VALUES (?, ?, ?, ?, ?)";
	var existQuery = "SELECT uname FROM logins WHERE uname=?";

	dbConn.query(existQuery, [staffMember.uname], function(err, result){
		if(err){
			console.log(err);
			return;
		}

		if(result.length != 0){
			console.log("User Exists");
			callBack({ status: "ERROR", message: "User Exists" });
			return;
		}

		dbConn.query(insertQuery, [staffMember.fname, staffMember.lname, staffMember.type, staffMember.contact, staffMember.branchId],
			function(err, result){
				if(err) console.log(err);
				staffMember.staff_id = result.insertId;
				console.log(staffMember);

				exports.createLogin(staffMember, function(result){
					callBack(result);
				});
		});
	});
}

exports.createCustomer = function(customer, callBack){
	console.log("Creating customer...");
	customer.passwd = sha1(customer.passwd);

	console.log(customer);

	var sql = "INSERT INTO customer (cust_fname, cust_lname, cust_cat, cust_contact, cust_addr) \
	VALUES (?, ?, ?, ?, ?)";

	var existQuery = "SELECT uname FROM logins WHERE uname=?";

	dbConn.query(existQuery, [customer.uname], function(err, result){
		console.log("Running query...");

		if(err){
			console.log(err);
			return;
		}

		if(result.length != 0){
			console.log("User Exists");
			callBack({ status: "ERROR", message: "User Exists" });
			return;
		}

		dbConn.query(sql, [customer.fname, customer.lname, customer.cat, customer.contact, customer.addr],
			function(err, result){
				if(err) console.log(err);
				customer.cust_id = result.insertId;

				exports.createLogin(customer, function(result){
					callBack(result);
				})
			}
		);
	});
}

exports.searchStaffByName = function(name, callBack){
	console.log("Looking for staff member " + name);
	var name = mysql.escape('%' + name + '%');

	var sql = "SELECT staff.staff_id AS id, staff.staff_type AS type, staff.staff_fname AS fname,\
	staff.staff_lname AS lname, staff.staff_contact AS contact, staff.branch_id AS branchId,\
	logins.uname FROM staff INNER JOIN logins ON logins.staff_id=staff.staff_id WHERE staff.staff_fname LIKE " + name +" OR staff.staff_lname LIKE " + name;

	dbConn.query(sql, function(err, result){
		if(err) console.log(err);
		callBack(result);
	});
}

exports.deleteStaffById = function(staffId, callBack){
	var sql = "DELETE FROM staff WHERE staff_id=?";

	dbConn.query(sql, [staffId], function(err, result){
		if(err) console.log(err);
		callBack(result);
	});
}

exports.updateStaffDetails = function(staffId, staffMember, callBack){
	var sql = "UPDATE staff SET staff_type=?, staff_contact=?, \
	u_name=? WHERE staff_id=?";

	dbConn.query(sql, [staffMember.type, staffMember.contact, staffMember.uname, staffId],
		function(err, result){
			if(err) console.log(err);
			callBack(result);
	});
}

exports.updateCustomerDetails = function(customer, callBack){
	var sql = "UPDATE customer SET (cust_fname, cust_lname, cust_contact, cust_addr)\
	(?, ?, ?, ?) WHERE cust_id=?";

	dbConn.query(sql, [customer.fname, customer.lname, customer.contact, customer.address, customer.id],
		function(err, result){
			if(err){
				console.log(err);
				return;
			}
		callBack(result);
	});
}
