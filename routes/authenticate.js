var express = require('express');
var jwt = require('jsonwebtoken');
var crypto = require('crypto');
var mailer = require('../mailer');

var router = express.Router();

var loginModel = require('../models/LoginModel');
var appSecret = require('../config').secret;

var issueToken = function(payload, response){
	jwt.sign(payload, appSecret, { issuer: 't35-api'}, function(err, token){
		if(err){
			res.json({
				status: "ERROR",
				message: err
			});
			return;
		}

		response.json({
			status: "OK",
			token: token,
			profile: payload
		});
	});
}

router.post('/authenticate', function(req, res){
	var token = req.body.token;

	jwt.verify(token, appSecret, function(err, payload){
		if(err){
			res.json({
				status: "ERROR",
				message: err
			});
			return;
		}

		res.json({
			status: "OK",
			payload: payload
		});
	});
});

router.post('/staff', function(req, res){

	var user = req.body;

	loginModel.getStaffMember(user, function(profile){
		if(profile.status === 'ERROR'){
			res.json(profile);
			return;
		}

		issueToken(profile, res);
	});
});

router.post('/customer', function(req, res){

	var user = req.body;

	loginModel.getCustomer(user, function(profile){
		if(profile.status === 'ERROR'){
			res.json(profile);
			return;
		}

		issueToken(profile, res);
	});
});

router.get('/forgot/:type/:uname', function(req, res){
	var uname = req.params.uname;
	var type = req.params.type;

	var resetToken = crypto.randomBytes(25).toString('hex');

	loginModel.getLoginInfo(uname, type, function(err, result){
		if(err){
			console.log(err);
			res.json(err);
			return;
		}
		console.log(result);
		loginModel.setToken(result[0].loginId, resetToken, function(result){
			res.json({ resetToken: resetToken });
		});
	});
});

router.post('/reset/:token', function(req, res){
	var token = req.params.token;
	var user = req.body;

	loginModel.resetPassword(user, token, function(result){
		res.json(result);
	});
});
module.exports = router;