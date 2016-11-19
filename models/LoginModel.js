var sha1 = require('sha1');
var dbConn = require('./../sqlConn');

exports.getStaffMember = function(user, callBack){
	console.log(user);

	user.passwd = sha1(user.passwd);

	var loginQuery = "SELECT logins.uname, staff.staff_id, staff.staff_fname, staff.staff_lname, staff.staff_type,\
	branch.branch_name, branch.branch_id FROM logins INNER JOIN (staff INNER JOIN branch ON staff.branch_id=branch.branch_id)\
	ON logins.staff_id = staff.staff_id WHERE logins.uname=? AND logins.passwd=?";

	dbConn.query(loginQuery, [user.uname, user.passwd], function(err, result){
		if(err){
			callBack({
				status: "ERROR",
				message: err
			})
		}

		console.log(result);

		if(result.length == 1){
			var userProfile = {
				status: "OK",
				uname: user.uname,
				staff_id: result[0].staff_id,
				fname: result[0].staff_fname,
				lname: result[0].staff_lname,
				type: result[0].staff_type,
				branchId: result[0].branch_id,
				branchName: result[0].branch_name
			};

			callBack(userProfile);
			return;
		}

		callBack({
			status: "ERROR",
			message: "Invalid login"
		});
	});
}

exports.getCustomer = function(user, callBack){
	console.log(user);

	user.passwd = sha1(user.passwd);

	var loginQuery = "SELECT logins.uname, customer.cust_id, customer.cust_fname, customer.cust_lname, customer.cust_cat\
	FROM logins, customer WHERE logins.uname=? AND logins.passwd=? AND logins.cust_id=customer.cust_id";

	dbConn.query(loginQuery, [user.uname, user.passwd], function(err, result){
		if(err){
			callBack({
				status: "ERROR",
				message: err
			});
			return;
		}

		console.log(result);

		if(result.length == 1){
			var userProfile = {
				status: "OK",
				uname: user.uname,
				cust_id: result[0].cust_id,
				fname: result[0].cust_fname,
				lname: result[0].cust_lname,
				type: result[0].cust_cat
			};

			callBack(userProfile);
			return;
		}

		callBack({
			status: "ERROR",
			message: "Invalid login"
		});
	});
}