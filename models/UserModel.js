var mysql = require('mysql');
var sha1 = require('sha1');
var dbConn = require('../sqlConn');

exports.createLogin = function(user, callBack){
	console.log(user);

	var query = "INSERT INTO logins (uname, passwd, staff_id, cust_id) VALUES (?, ?, ?, ?)";

	dbConn.query(query, [user.uname, user.passwd, user.staff_id, user.cust_id],
		function(err, result){
			if(err) console.log(err);
			result.user = user;
			callBack(result);
	});
}

exports.createStaffMember = function(staffMember, callBack){
	staffMember.passwd = sha1(staffMember.passwd);

	var sql = "INSERT INTO staff (staff_fname, staff_lname, staff_type, staff_contact)\
		VALUES (?, ?, ?, ?)";

	dbConn.query(sql, [staffMember.fname, staffMember.lname, staffMember.type, staffMember.contact], 
		function(err, result){
			if(err) console.log(err);
			staffMember.staff_id = result.insertId;
			console.log(staffMember);

			exports.createLogin(staffMember, function(result){
				callBack(result);
			});
	});
}

exports.createCustomer = function(customer, callBack){
	customer.passwd = sha1(customer.passwd);

	var conn = this;

	var sql = "INSERT INTO customer (cust_fname, cust_lname, cust_cat, cust_contact, cust_addr) \
	VALUES (?, ?, ?, ?, ?)";

	conn.connection.query(sql, [customer.fname, customer.lname, customer.cat, customer.contact, customer.addr],
		function(err, result){
			if(err) console.log(err);
			customer.cust_id = result.insertId;

			conn.createLogin(customer, function(result){
				callBack(result);
			})
		}
	);
}

exports.searchStaffByName = function(name, callBack){
	console.log("Looking for staff member " + name);
	var name = mysql.escape('%' + name + '%');

	var sql = "SELECT * FROM staff WHERE staff_fname LIKE " + name +" OR staff_lname LIKE " + name;
	console.log(sql);

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