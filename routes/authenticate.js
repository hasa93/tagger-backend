var express = require('express');
var jwt = require('jsonwebtoken');

var router = express.Router();

var loginModel = require('../models/LoginModel');
var appSecret = require('../config').secret;

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

	var issueToken = function(payload){
		jwt.sign(payload, appSecret, { issuer: 't35-api'}, function(err, token){
			if(err){
				res.json({
					status: "ERROR",
					message: err
				});
				return;
			}

			res.json({
				status: "OK",
				token: token,
				profile: payload
			});
		});
	}

	loginModel.getStaffMember(user, function(profile){
		if(profile.status === 'ERROR'){
			res.json(profile);
			return;
		}

		issueToken(profile);
	});
});

module.exports = router;