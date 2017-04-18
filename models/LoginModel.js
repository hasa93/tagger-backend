var sha1 = require('sha1');
var dbConn = require('./../sqlConn');


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

exports.getLoginInfo = function(email, callBack){

	var userQuery = "SELECT login_id AS loginId FROM logins where email=?";

	dbConn.query(userQuery, [email], function(err, result){
		if(err || result.length == 0){
			callBack(err, null);
			return;
		}

		callBack(null, result);
	});
}



exports.setToken = function(userId, resetToken, callBack){
	var date = new Date();
	date.setDate(date.getDate() + 1);
	console.log(date.getTime());

	var tokenQuery = "UPDATE logins SET token_expiry=?, reset_token=? WHERE login_id=?";

	dbConn.query(tokenQuery, [date.getTime().toString(), resetToken, userId], function(err, result){
		if(err){
			console.log(err);
			callBack(err);
			return;
		}
		callBack(result);
	});
}