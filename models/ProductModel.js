var mysql = require('mysql');
var dbConn = require('../sqlConn');
var fs = require('fs');

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

		console.log(result[0].prod_image);

		fs.readFile(result[0].prod_image, function(err, file){
			var b64 = new Buffer(file).toString('base64');
			result[0].prod_image = b64;
			callBack(result);
		});

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

exports.getMostRecentProducts = function(count, callBack){
	console.log(parseInt(count));
	var sql = "SELECT prod_name AS prodName, unit_price AS price, arr_date AS date,\
					  age_range AS ageRange, prod_image AS prodImage FROM products ORDER BY(arr_date) DESC LIMIT " + parseInt(count);

	console.log(sql);

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.getFlags = function(custId, callBack){

	var sql = "SELECT cust_id AS custId, prod_id AS prodId FROM flags WHERE cust_id=?";

	dbConn.query(sql, [custId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}
