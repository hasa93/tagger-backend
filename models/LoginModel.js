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
			console.log(err);
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

	var loginQuery = "SELECT logins.uname,\
							 customer.cust_id AS id,\
							 customer.cust_fname AS fname,\
							 customer.cust_lname AS lname,\
							 customer.cust_cat AS cat,\
							 customer.cust_contact AS contact\
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
			var userProfile = result[0];
			userProfile.uname = user.uname;
			callBack(userProfile);
			return;
		}

		callBack({
			status: "ERROR",
			message: "Invalid login"
		});
	});
}

exports.getLoginInfo = function(uname, type, callBack){
	var userQuery = "";

	if(type === 'cust'){
		userQuery = "SELECT customer.cust_contact AS mail,\
							customer.cust_id AS id,\
							logins.login_id AS loginId\
							FROM customer INNER JOIN logins \
							ON customer.cust_id = logins.cust_id \
							WHERE logins.uname=?";
	}
	else if(type === 'staff'){
		userQuery = "SELECT staff.staff_contact AS mail,\
							staff.staff_id AS id,\
							logins.login_id AS loginId\
							FROM staff INNER JOIN logins\
							ON staff.staff_id = logins.staff_id\
							WHERE logins.uname=?";
	}
	else{
		callBack({ status: 'ERROR', msg: 'Invalid type' }, null);
		return;
	}

	dbConn.query(userQuery, [uname], function(err, result){
		if(err || result.length == 0){
			console.log(err);
			callBack(err, null);
			return;
		}

		callBack(null, result);
	});
}

exports.resetPassword = function(user, token, callBack){

	var tokenQuery = "SELECT login_id, token_expiry FROM logins WHERE reset_token=?";

	dbConn.query(tokenQuery, [token], function(err, result){
		if(err || result.length == 0){
			callBack({ status: 'ERROR', msg: 'Invalid Reset Token' });
			return;
		}

		var expiry = result[0].token_expiry;
		var loginId = result[0].login_id;
		var date = new Date();

		console.log(expiry);
		console.log(date.getTime());

		if(expiry < date.getTime()){
			callBack({ status: 'ERROR', mgs: 'Reset token expired' });
			return;
		}

		if(user.newpasswd != user.confirmpasswd){
			callBack({ status: 'ERROR', msg: 'Password mismatch'});
			return;
		}

		var resetQuery = "UPDATE logins SET passwd=? WHERE login_id=?";

		var deleteToken = function(token, callBack){
			var deleteTokenQuery = "UPDATE logins SET reset_token=NULL, token_expiry=NULL\
			WHERE reset_token=?";

			dbConn.query(deleteTokenQuery, [token], callBack);
		}

		dbConn.query(resetQuery, [sha1(user.newpasswd), loginId], function(err, result){
			if(err){
				console.log(err);
				callBack({ status: 'ERROR', msg: err });
				return;
			}

			deleteToken(token, function(){
				callBack({ status: "SUCCESS" });
			})
		});
	});
}

exports.setToken = function(loginId, resetToken, callBack){
	var tokenQuery = "";
	var date = new Date();
	date.setDate(date.getDate() + 1);
	console.log(date.getTime());

	var tokenQuery = "UPDATE logins SET token_expiry=?, reset_token=? WHERE login_id=?";

	dbConn.query(tokenQuery, [date.getTime().toString(), resetToken, loginId], function(err, result){
		if(err){
			console.log(err);
			callBack(err);
			return;
		}
		callBack(result);
	});
}