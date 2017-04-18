var express = require('express');
var userModel = require('../models/UserModel');
var router = express.Router();
var authenticator = require('./authenticator');



router.post('/create/customer', function(req, res){
	var customer = req.body;
	console.log(req.body);

	userModel.createCustomer(customer, function(result){
		result.customer = customer;
		res.json(result);
	});
});

router.post('/update/customer', authenticator.authenticateUser, function(req, res){
	var customer = req.body;

	userModel.updateCustomerDetails(customer, function(result){
		res.json(result);
	});
});

module.exports = router;