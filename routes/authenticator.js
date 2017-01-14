var express = require('express');
var jwt = require('jsonwebtoken');
var appSecret = require('../config').secret;

var staffAuthenticator = function(profile){
	if(profile.type === 'mgr' || profile.type === 'csh'){
		return true;
	}
	return false;
}

var adminAuthenticator = function(profile){
	console.log("admin auth");
	console.log(profile);

	if(profile.type === 'mgr'){
		return true;
	}
	return false;
}

var masterAuthenticator = function(profile){
	if(profile.type === 'adm'){
		return true
	}
	return false;
}

var verifyToken = function(authorizer, req, res, next){
	var token = req.headers.token;

	jwt.verify(token, appSecret, function(err, payload){
		if(!payload || !authorizer(payload)){
			res.json({
				status: 'ERROR',
				message: 'Invalid token'
			});
			return;
		}
		next();
	})
}

exports.authenticateAdmin = function(req, res, next){
	verifyToken(adminAuthenticator, req, res, next);
}

exports.authenticateStaff = function(req, res, next){
	verifyToken(staffAuthenticator, req, res, next);
}

exports.authenticateMaster = function(req, res, next){
	verifyToken(masterAuthenticator, req, res, next);
}

exports.authenticateUser = function(req, res, next){
	verifyToken(function(profile){
		return profile;
	}, req, res, next);
}
