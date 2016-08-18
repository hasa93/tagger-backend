var express = require('express');
var productModel = require('../models/ProductModel');
var router = express.Router();

router.get('/list', function(req, res){
	productModel.getProductList(function(list){
		res.json(list);
	});
});

router.get('/find/name/:name', function(req, res){
	productModel.getProductsByName(req.params.name, function(result){
		res.json(result);
	});
});

router.get('/find/id/:prodId', function(req, res){
	var prodId = req.params.prodId;
	productModel.getProductById(prodId, function(rows){
		res.json(rows);
	});
});

router.post('/delete/:id', function(req, res){
	productModel.deleteProduct(req.params.id, function(result){
		res.json(result);
	});
});


module.exports = router;