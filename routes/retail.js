var express = require('express');
var retailModel = require('../models/RetailModel');
var router = express.Router();

router.post('/insert/purchase', function(req, res){
	var receipt = req.body;
	retailModel.insertPurchaseRec(receipt);
});

router.post('/create/voucher', function(req, res){
	var voucher = req.body;
	retailModel.createVoucher(voucher, function(result){
		res.json(result);
	});
});

router.get('/find/voucher/:id', function(req, res){
	retailModel.findVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/claim/voucher/:id', function(req, res){
	retailModel.claimVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/inventory/update', function(req, res){
	var inventoryLevel = req.body;
	retailModel.updateInventoryLevel(inventoryLevel, function(result){
		res.json(result);
	});
});

module.exports = router;