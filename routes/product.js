var express = require('express');
var productModel = require('../models/ProductModel');
var router = express.Router();
var authenticator = require('./authenticator');
var fs = require('fs');

router.get('/list', authenticator.authenticateStaff, function(req, res){
	productModel.getProductList(function(list){
		res.json(list);
	});
});

router.get('/find/name/:name', authenticator.authenticateStaff, function(req, res){
	productModel.getProductsByName(req.params.name, function(result){
		res.json(result);
	});
});

router.get('/find/id/:prodId', authenticator.authenticateStaff, function(req, res){
	var prodId = req.params.prodId;
	productModel.getProductById(prodId, function(rows){
		res.json(rows);
	});
});

router.get('/find/uid/:prodUid', authenticator.authenticateStaff, function(req, res){
	var prodUid = req.params.prodUid;
	productModel.getProductByTag(prodUid, function(result){
		res.json(result);
	});
});

router.post('/delete/:id', authenticator.authenticateAdmin, function(req, res){
	productModel.deleteProduct(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/insert', authenticator.authenticateAdmin, function(req, res){
	var product = req.body;
	productModel.insertProduct(product, function(result){
		res.json(result);
	});
});

router.post('/insert/tag', authenticator.authenticateAdmin, function(req, res){
	var productTag = req.body;
	productModel.insertProductTag(productTag, function(result){
		res.json(result);
	});
});

router.post('/update/:id', authenticator.authenticateAdmin, function(req, res){
	var updateData = req.body;
	var prodId = req.params.id;

	productModel.updateProduct(prodId, updateData, function(result){
		res.json(result);
	});
});

//Protect these routes before deployment
router.get('/new/arrivals/:count', function(req, res){
	var counts = req.params.count;
	console.log(counts);
	productModel.getMostRecentProducts(counts, function(result){
		res.json(result);
	});
});

router.post('/get/flagged', function(req, res){
	var custId = req.body.custId;

	productModel.getFlags(custId, function(result){
		res.json(result);
	});
});

module.exports = router;