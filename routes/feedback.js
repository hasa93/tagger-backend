var express = require('express');
var userModel = require('../models/FeedbackModel');
var router = express.Router();
var authenticator = require('./authenticator');



router.post('/feedback', function(req, res){
	var customer = req.body;
	console.log(req.body);

	FeedbackModel.sendfeedback(customer, function(result){
		result.customer = customer;
		res.json(result);
	});
});

module.exports = router;