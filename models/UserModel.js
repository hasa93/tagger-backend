var mysql = require('mysql');
var sha1 = require('sha1');
var dbConn = require('../sqlConn');

exports.createLogin = function(user, callBack){
	console.log(user);

	var createQuery = "INSERT INTO logins (uname, passwd, email, staff_id, cust_id) VALUES (?, ?, ?, ?, ?)";

	dbConn.query(createQuery, [user.uname, user.passwd, user.email, user.staff_id, user.cust_id],
		function(err, result){
			if(err){
				callBack({ status: "ERROR", msg: err });
				console.log(err);
				return;
			}
			result.user = user;
			callBack(result);
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
			callBack({ status: "ERROR", msg: err });
			console.log(err);
			return;
		}

		if(result.length > 0){
			console.log("User Exists");
			callBack({ status: "ERROR", message: "User Exists" });
			return;
		}

		dbConn.query(sql, [customer.fname, customer.lname, customer.cat, customer.contact, customer.email],
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

exports.updateCustomerDetails = function(customer, callBack){
	var customerUpdate = "UPDATE customer SET cust_fname=?, cust_lname=?, cust_contact=?\
	WHERE cust_id=?";
	var existQuery = "SELECT cust_id FROM customer WHERE cust_contact=?";

	dbConn.query(existQuery, [customer.contact], function(err, result){
		if(err){
			console.log(err);
			callBack({ status: "ERROR", msg: err });
			return;
		}

		if(result.length > 1){
			callBack({ status: "ERROR", msg: "Contact Exists" });
			return;
		}
		else if(result.length == 1 && customer.id != result[0].cust_id){
			callBack({ status: "ERROR", msg: "Contact Exists" });
			return;
		}

		dbConn.query(customerUpdate, [customer.fname, customer.lname, customer.contact, customer.id],
			function(err, result){
				if(err){
					console.log(err);
					callBack({ status: "ERROR", msg: err });
					return;
				}

			callBack(result);
		});
	});
}
