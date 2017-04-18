var express = require('express');
var productModel = require('../models/ProductModel');
var router = express.Router();
var authenticator = require('./authenticator');
var uploader = require('../uploader');
var fs = require('fs');

router.get('/list', authenticator.authenticateUser, function(req, res){
	productModel.getProductList(function(list){
		res.json(list);
	});
});

router.get('/find/name/:name', authenticator.authenticateUser, function(req, res){
	productModel.getProductsByName(req.params.name, function(result){
		res.json(result);
	});
});

router.get('/find/id/:prodId', authenticator.authenticateStaff, function(req, res){
	var prodId = req.params.prodId;
	productModel.getProductById(prodId, function(result){
		res.json(result);
	});
});

router.get('/find/uid/:prodUid', authenticator.authenticateUser, function(req, res){
	var prodUid = req.params.prodUid;
	productModel.getProductByTag(prodUid, function(result){
		res.json(result);
	});
});

router.post('/insert/tag', authenticator.authenticateStaff, function(req, res){
	var productTag = req.body;
	productModel.insertProductTag(productTag, function(result){
		res.json(result);
	});
});



router.get('/recent/:category/:count', authenticator.authenticateUser, function(req, res){
	var counts = req.params.count;
	var category = req.params.category;
	var custId = req.params.custId;

	productModel.getMostRecentProducts(counts, category,function(result){
		res.json(result);
	});
});

router.get('/get/flagged/:id', authenticator.authenticateUser, function(req, res){
	var custId = req.params.id;

	productModel.getFlaggedProducts(custId, function(result){
		if(result == undefined){
			res.json({ status: 'ERROR', msg: 'Product not found'});
			return;
		}
		res.json(result);
	});
});

router.post('/get/prefs/:custId', authenticator.authenticateUser, function(req, res){
	var custId = req.params.custId;
	var product = req.body;

	productModel.getCustomerPreferences(product, custId, function(result){
		res.json(result);
	});
});

router.post('/rate', authenticator.authenticateUser, function(req, res){
	var rating = req.body;
	productModel.rateProduct(rating, function(result){
		res.json(result);
	});
});

module.exports = router;