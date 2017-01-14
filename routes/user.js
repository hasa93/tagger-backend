var express = require('express');
var userModel = require('../models/UserModel');
var router = express.Router();
var authenticator = require('./authenticator');

router.post('/create/staff', authenticator.authenticateAdmin, function(req, res){
	var staffMember = req.body;

	userModel.createStaffMember(staffMember, function(result){
		result.staffMember = staffMember;
		res.json(result);
	})
});

router.post('/create/customer', function(req, res){
	var customer = req.body;
	console.log(req.body);

	userModel.createCustomer(customer, function(result){
		result.customer = customer;
		res.json(result);
	});
});

router.get('/find/staff/:name', authenticator.authenticateAdmin, function(req, res){
	var name = req.params.name;

	userModel.searchStaffByName(name, function(result){
		res.json(result);
	});
});

router.post('/delete/staff/:id', authenticator.authenticateAdmin, function(req, res){
	var staffId = req.params.id;

	userModel.deleteStaffById(staffId, function(result){
		res.json(result);
	})
});

router.post('/update/staff', authenticator.authenticateAdmin, function(req, res){
	var staffMember = req.body;

	userModel.updateStaffDetails(staffMember, function(result){
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