var express = require('express');
var productModel = require('../models/ProductModel');
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

router.get('/list', staffAuthenticator, function(req, res){
	productModel.getProductList(function(list){
		res.json(list);
	});
});

router.get('/find/name/:name', staffAuthenticator, function(req, res){
	productModel.getProductsByName(req.params.name, function(result){
		res.json(result);
	});
});

router.get('/find/id/:prodId', staffAuthenticator, function(req, res){
	var prodId = req.params.prodId;
	productModel.getProductById(prodId, function(rows){
		res.json(rows);
	});
});

router.get('/find/uid/:prodUid', staffAuthenticator, function(req, res){
	var prodUid = req.params.prodUid;
	productModel.getProductByTag(prodUid, function(result){
		res.json(result);
	});
});

router.post('/delete/:id', adminAuthenticator, function(req, res){
	productModel.deleteProduct(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/insert', adminAuthenticator, function(req, res){
	var product = req.body;
	productModel.insertProduct(product, function(result){
		res.json(result);
	});
});

router.post('/insert/tag', adminAuthenticator, function(req, res){
	var productTag = req.body;
	productModel.insertProductTag(productTag, function(result){
		res.json(result);
	});
});

router.post('/update/:id', adminAuthenticator, function(req, res){
	var updateData = req.body;
	var prodId = req.params.id;

	productModel.updateProduct(prodId, updateData, function(result){
		res.json(result);
	});
});

module.exports = router;