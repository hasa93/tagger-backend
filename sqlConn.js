var mysql = require('mysql');
var config = require('./config.js');


var dbconn = mysql.createConnection(config.db);

dbconn.connect(function(err){
	if(err){
		console.log('Connection failed due to: ' + err);
		return;
	}
	console.log('Connection succeeded!');
});

module.exports = dbconn;