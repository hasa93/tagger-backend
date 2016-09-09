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

exports.getProductByTag = function(prodUid, callBack){
	var sql = "SELECT products.* FROM products, tag_map WHERE products.prod_id=tag_map.prod_id\
	AND tag_map.tag_uid=? AND products.discontinued IS FALSE";

	dbConn.query(sql, [prodUid], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.getProductById = function(prodId, callBack){

	var sql = "SELECT prod_id as id, prod_name AS name, unit_price AS price, prod_cat AS cat, DATE(arr_date) AS arrival, age_range AS age FROM products WHERE prod_id=? AND discontinued IS FALSE";

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
	var sql = "SELECT prod_id as id, prod_name AS name, unit_price AS price, prod_cat AS cat, DATE(arr_date) AS arrival, age_range AS age FROM products WHERE prod_name LIKE" + prodName + " AND \
	discontinued IS FALSE";

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.getProductByTag = function(tagId, callBack){
	var tagQuery = "SELECT prod_id FROM tag_map WHERE tag_uid=?";

	dbConn.query(tagQuery, [tagId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.insertProductTag = function(productTag, callBack){
	var sql = "INSERT INTO tag_map VALUE (?, ?)";

	dbConn.query(sql, [productTag.uid, productTag.prodId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.updateProduct = function(prodId, delta, callBack){
	console.log(delta);

	var sql = "UPDATE products SET prod_name=?, unit_price=?, age_range=?,\
	prod_cat=?, arr_date=? WHERE prod_id=?";

	dbConn.query(sql, [delta.name, delta.price, delta.age, delta.cat, delta.arrival, prodId], function(err, result){
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

exports.insertProduct = function(product, callBack){
	var sql = "INSERT INTO products (prod_name, unit_price, prod_cat, arr_date, age_range) VALUES\
	(?, ?, ?, ?, ?)";

	dbConn.query(sql, [product.name, product.price, product.category, product.arrival, product.age], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}
