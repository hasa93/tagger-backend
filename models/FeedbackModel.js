var mysql = require('mysql');
var sha1 = require('sha1');
var dbConn = require('../sqlConn');

exports.sendFeedback = function(feedback, callBack){
	console.log("sending feedback...");

	var sql = "INSERT INTO feedback (cus_feed) \
	VALUES (?)";

	dbConn.query(sql, [customer.feedback],
			function(err, result){
				if(err) console.log(err);
				customer.cus_id = result.insertId;

			}
		);
}