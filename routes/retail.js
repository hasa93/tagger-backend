var express = require('express');
var retailModel = require('../models/RetailModel');
var router = express.Router();
var jwt = require('jsonwebtoken');
var appSecret = require('../config').secret;

var decodeToken = function(token, cb){

	if(!token){
		cb(false);
	}

	jwt.verify(token, appSecret, function(err, payload){
		if(err){
			cb(false);
		}

		cb(payload);
	});
}

//Might need a better fix than this
var staffAuthenticator = function(req, res, next){
	decodeToken(req.headers.token, function(payload){
		if(payload === false){
			res.json({
				status: 'ERROR',
				message: 'Invalid token'
			});
		}

		if(payload.type == 'mgr' || payload.type == 'csh'){
			return next()
		}

		res.json({
			status: 'ERROR',
			message: 'Needs to be staff'
		});
	});
}

var adminAuthenticator = function(req, res, next){
	decodeToken(req.headers.token, function(payload){
		if(payload === false){
			res.json({
				status: 'ERROR',
				message: 'Invalid token'
			});
		}

		if(payload.type == 'mgr'){
			return next()
		}

		res.json({
			status: 'ERROR',
			message: 'Needs to be admin'
		});
	});
}

router.post('/insert/purchase', staffAuthenticator, function(req, res){
	var receipt = req.body;
	retailModel.insertPurchaseRec(receipt);
});

router.post('/create/voucher', staffAuthenticator, function(req, res){
	var voucher = req.body;
	retailModel.createVoucher(voucher, function(result){
		res.json(result);
	});
});

router.get('/find/voucher/:id', staffAuthenticator, function(req, res){
	retailModel.findVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/claim/voucher/:id', staffAuthenticator, function(req, res){
	retailModel.claimVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/inventory/update', staffAuthenticator, function(req, res){
	var inventoryLevel = req.body;
	retailModel.updateInventoryLevel(inventoryLevel, function(result){
		res.json(result);
	});
});

router.post('/create/invoice', staffAuthenticator, function(req, res){
	var ticket = req.body;
	retailModel.createInvoice(ticket, function(result){
		res.json(result);
	})
});

module.exports = router;