var express = require('express');
var jwt = require('jsonwebtoken');

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
	var type = req.params.type;
	var uname = req.params.uname;

	loginModel.getUserMail(uname, type, function(err, result){
		if(err){
			console.log(err);
			res.json(err);
			return;
		}

		var user = result[0];
		console.log(user);

		var token = jwt.sign({ data: user }, appSecret , {
			issuer: 't35-api',
			expiresIn:  '24h' });

		console.log(token);
		res.json(token);
	})
});
module.exports = router;