var express = require('express');
var productModel = require('../models/RetailModel');
var router = express.Router();

router.post('/insert/purchase', function(req, res){
	var receipt = req.body;
	productModel.insertPurchaseRec(receipt);
});

router.post('/create/voucher', function(req, res){
	var voucher = req.body;
	productModel.createVoucher(voucher, function(result){
		res.json(result);
	});
});

router.get('/find/voucher/:id', function(req, res){
	productModel.findVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/claim/voucher/:id', function(req, res){
	productModel.claimVoucher(req.params.id, function(result){
		res.json(result);
	});
});

module.exports = router;