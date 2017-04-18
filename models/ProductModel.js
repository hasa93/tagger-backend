var mysql = require('mysql');
var dbConn = require('../sqlConn');
var fs = require('fs');

exports.getCustomerPreferences = function(product, custId, callBack){
	var customerQuery = "SELECT IFNULL((SELECT cust_id FROM flags WHERE cust_id = ? AND prod_id = ?), null) AS flag,\
			 IFNULL((SELECT prod_rating FROM ratings WHERE cust_id = ? AND prod_id=?), null) AS ratings";

	dbConn.query(customerQuery, [custId, product.id, custId, product.id], function(err, prefs){
	 	if(err){
	 		console.log(err);
	 		callBack({ status: "ERROR", msg: err });
	 		return;
		}

		callBack(prefs);
	 });
}

exports.getProductList = function(callBack){
	var sql = "SELECT products.prod_name AS name,\
					  products.prod_id AS id,\
					  products.prod_cat AS cat,\
					  products.age_range AS age,\
					  DATE(products.arr_date) AS date,\
					  products.prod_image AS image,\
					  products.prod_desc AS descr\
					  FROM products WHERE discontinued IS FALSE";

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.getProductByTag = function(prodUid, callBack){
	var sql = "SELECT products.prod_name AS name,\
					  products.prod_id AS id,\
					  products.prod_cat AS cat,\
					  products.age_range AS age,\
					  DATE(products.arr_date) AS date,\
					  products.prod_image AS image,\
					  products.unit_price AS price,\
					  products.prod_desc AS descr\
	 FROM products, tag_map WHERE products.prod_id=tag_map.prod_id\
	AND tag_map.tag_uid=? AND products.discontinued IS FALSE";

	dbConn.query(sql, [prodUid], function(err, result){
		if(err || result.length == 0){
			console.log(err);
			return;
		}

		callBack(result);
	});
}

exports.getProductById = function(prodId, callBack){
	console.log("Get product by id");
	console.log(__dirname);

	var sql = "SELECT prod_id AS id,\
					  prod_name AS name,\
					  unit_price AS price,\
					  prod_cat AS cat,\
					  DATE(arr_date) AS arrival,\
					  age_range AS age,\
					  prod_image AS image,\
					  prod_desc AS descr\
					  FROM products WHERE prod_id=? AND discontinued IS FALSE";

	dbConn.query(sql, [prodId], function(err, result){
		if(err || result.length == 0 || result == null){
			console.log(err);
			callBack();
			return;
		}
		callBack(result);
	});
}
exports.getMostRecentProducts = function(count, category, callBack){
	console.log(parseInt(count));
	var sql = "SELECT prod_id AS id,\
					  prod_name AS name,\
					  unit_price AS price,\
					  arr_date AS date,\
					  age_range AS age,\
					  prod_image AS image,\
					  prod_desc AS descr\
					  FROM products WHERE prod_cat=? AND discontinued IS FALSE\
					  ORDER BY(arr_date) DESC LIMIT " + parseInt(count);

	dbConn.query(sql, [category], function(err, result){
		if(err || result == null || result.length == 0){
			console.log(err);
			callBack({ status: "ERROR", msg: err });
			return;
		}

		callBack(result);
	});
}

exports.getProductImage = function(prodId, callBack){
	var sql = "SELECT prod_image FROM products WHERE products.prod_id=?";

	dbConn.query(sql, [prodId], function(err, result){
		if(err || result.length === 0){
			console.log(err);
			return;
		}

		var fname = result[0].prod_image;
		console.log(fname);
		callBack(fname);
	});
}

exports.getFlaggedProducts = function(custId, callBack){
	var sql = "SELECT products.prod_id AS id,\
					  products.prod_name AS name,\
					  products.unit_price AS price,\
					  products.arr_date AS date,\
					  products.age_range AS age,\
					  products.prod_image AS image,\
					  products.prod_desc AS descr\
					  FROM flags INNER JOIN products ON flags.prod_id=products.prod_id WHERE cust_id=?";

	dbConn.query(sql, [custId], function(err, result){
		if(err || result.length === 0){
			console.log(err);
			callBack({ status: "ERROR", msg: err });
			return;
		}
		callBack(result);
	});
}

exports.rateProduct = function(rating, callBack){
	var ratingQuery = "INSERT INTO ratings VALUES (?, ?, ?) ON DUPLICATE KEY\
	UPDATE prod_rating=?";

	dbConn.query(ratingQuery, [rating.custId, rating.prodId, rating.prodRating, rating.prodRating], function(err, result){
		if(err){
			console.log(err);
			callBack({ status: "ERROR", msg: err });
			return;
		}
		callBack({ status: "SUCCESS" });
	});
}
