var sha1 = require('sha1');
var dbConn = require('./../sqlConn');

exports.getStaffMember = function(user, callBack){
	console.log(user);

	user.passwd = sha1(user.passwd);

	var sql = "SELECT logins.uname, staff.staff_id, staff.staff_fname, staff.staff_lname, staff.staff_type\
	FROM logins, staff WHERE logins.uname=? AND logins.passwd=? AND logins.staff_id=staff.staff_id";

	dbConn.query(sql, [user.uname, user.passwd], function(err, result){
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
				type: result[0].staff_type
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