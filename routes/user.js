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

router.post('/update/staff/details/:id', authenticator.authenticateAdmin, function(req, res){
	var staffMember = req.body;
	var staffId = req.params.id;

	userModel.updateStaffDetails(staffId, staffMember, function(result){
		res.json(result);
	});
});

module.exports = router;