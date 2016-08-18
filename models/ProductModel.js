var mysql = require('mysql');
var dbConn = require('../sqlConn');

exports.getProductList = function(callBack){
	var sql = "SELECT * FROM products WHERE discontinued IS FALSE";

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.getProductById = function(prodId, callBack){

	var sql = "SELECT * FROM products WHERE prod_id=? AND discontinued IS FALSE";

	dbConn.query(sql, [prodId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.getProductsByName = function(prodName, callBack){
	var prodName = mysql.escape('%' + prodName + '%');
	var sql = "SELECT * FROM products WHERE prod_name LIKE" + prodName + " AND \
	discontinued IS FALSE";

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.updateProduct = function(product, callBack){
	var sql = "UPDATE products SET prod_name=?, unit_price=? WHERE prod_id=?";

	dbConn.query(sql, [product.name, product.price, product.id], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.deleteProduct = function(productId, callBack){
	var sql = "UPDATE products SET discontinued=TRUE WHERE prod_id=?";

	dbConn.query(sql, [productId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}
