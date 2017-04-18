var express = require('express');
var retailModel = require('../models/RetailModel');
var router = express.Router();
var authenticator = require('./authenticator');



router.post('/flag', authenticator.authenticateUser, function(req, res){
	var flag = req.body;

	retailModel.flagProduct(flag.prodId, flag.custId, function(result){
		res.json(result);
	});
});

router.post('/flag/remove', authenticator.authenticateUser, function(req, res){
	var flag = req.body;

	retailModel.removeFlag(flag.prodId, flag.custId, function(result){
		res.json(result);
	});
});


module.exports = router;