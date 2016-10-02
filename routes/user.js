var express = require('express');
var userModel = require('../models/UserModel');
var router = express.Router();
var jwt = require('jsonwebtoken');
var appSecret = require('../config').secret;

var authenticator = function(req, res, next){
  var token = req.headers.token;

  jwt.verify(token, appSecret, function(err, payload){
		if(err || payload.type != 'mgr'){
			res.json({
				status: "ERROR",
				message: err
			});
			return;
		}
		next();
	});
}

router.post('/create/staff', authenticator, function(req, res){
	var staffMember = req.body;

	userModel.createStaffMember(staffMember, function(result){
		result.staffMember = staffMember;
		res.json(result);
	})
});

router.post('/create/customer', authenticator, function(req, res){
	var customer = req.body;

	userModel.createCustomer(customer, function(result){
		result.customer = customer;
		res.json(result);
	});
});

router.get('/find/staff/:name', authenticator, function(req, res){
	var name = req.params.name;

	userModel.searchStaffByName(name, function(result){
		res.json(result);
	});
});

router.post('/delete/staff/:id', authenticator, function(req, res){
	var staffId = req.params.id;

	userModel.deleteStaffById(staffId, function(result){
		res.json(result);
	})
});

router.post('/update/staff/details/:id', authenticator, function(req, res){
	var staffMember = req.body;
	var staffId = req.params.id;

	userModel.updateStaffDetails(staffId, staffMember, function(result){
		res.json(result);
	});
});

module.exports = router;