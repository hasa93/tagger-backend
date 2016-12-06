var express = require('express');
var productModel = require('../models/ProductModel');
var router = express.Router();
var authenticator = require('./authenticator');
var uploader = require('../uploader');
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
	productModel.getProductById(prodId, function(result){
		res.json(result);
	});
});

router.get('/find/uid/:prodUid', authenticator.authenticateToken, function(req, res){
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
	console.log("Inserting product");

	uploader(req, res, function(err){
		console.log("Uploading image...");
		console.log(req);

		if(err){
			console.log(err);
			return;
		}

		var image = 'thumbs/default.png';


		if(req.file !== undefined){
			console.log("File exists...");
			image = req.file.filename;
		}

		var product = req.body;
		product.image = image;

		console.log(product);

		productModel.insertProduct(product, function(result){
			res.json(result);
		});
	});
});

router.post('/insert/tag', authenticator.authenticateAdmin, function(req, res){
	var productTag = req.body;
	productModel.insertProductTag(productTag, function(result){
		res.json(result);
	});
});

router.post('/update/:id', authenticator.authenticateAdmin, function(req, res){
	var prodId = req.params.id;

	uploader(req, res, function(err){
		console.log("Uploading image...");
		console.log(req);

		if(err){
			console.log(err);
			return;
		}

		var product = JSON.parse(req.body.product);

		if(req.file !== undefined){
			console.log("File exists...");
			product.image = req.file.filename;
		}


		console.log(product);

		productModel.updateProduct(prodId, product, function(result){
			res.json(result);
		});
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

router.get('/get/flagged/:id', function(req, res){
	var custId = req.params.id;

	productModel.getFlaggedProducts(custId, function(result){
		if(result == undefined){
			res.json({ status: 'ERROR', msg: 'Product not found'});
			return;
		}
		res.json(result);
	});
});

router.get('/get/image/:id', function(req, res){
	var prodId = req.params.id;
	res.sendFile('public/dress-one.jpg');
});

module.exports = router;