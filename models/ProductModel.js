var mysql = require('mysql');
var dbConn = require('../sqlConn');
var fs = require('fs');

var convertToB64 = function(product, callBack){
	fs.readFile(product.image, function(err, file){
		if(err){
			console.log(err);
			return;
		}

		var b64 = new Buffer(file).toString('base64');
		product.image = b64;
		callBack(product);
	});
}

exports.getProductList = function(callBack){
	var sql = "SELECT products.prod_name AS name,\
					  products.prod_id AS id,\
					  products.prod_cat AS cat,\
					  products.age_range AS age,\
					  DATE(products.arr_date) AS date,\
					  products.prod_image AS image,\
					  products.prod_desc AS desc\
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
					  products.prod_desc AS desc\
	 FROM products, tag_map WHERE products.prod_id=tag_map.prod_id\
	AND tag_map.tag_uid=? AND products.discontinued IS FALSE";

	dbConn.query(sql, [prodUid], function(err, result){
		if(err || result.length == 0){
			console.log(err);
			return;
		}

		console.log(result);

		convertToB64(result[0], function(result){
			callBack([result]);
		});
	});
}

exports.getProductById = function(prodId, callBack){

	var sql = "SELECT prod_id AS id,\
					  prod_name AS name,\
					  unit_price AS price,\
					  prod_cat AS cat,\
					  DATE(arr_date) AS arrival,\
					  age_range AS age,\
					  prod_image AS image\
					  FROM products WHERE prod_id=? AND discontinued IS FALSE";

	dbConn.query(sql, [prodId], function(err, result){
		if(err || result.length == 0){
			console.log(err);
			return;
		}

		console.log(result);
		convertToB64(result[0], function(result){
			callBack([result]);
		});
	});
}

exports.getProductsByName = function(prodName, callBack){
	var prodName = mysql.escape('%' + prodName + '%');
	var sql = "SELECT prod_id as id, prod_name AS name, unit_price AS price, \
				prod_cat AS cat, DATE(arr_date) AS arrival,\
				age_range AS age FROM products WHERE prod_name LIKE" + prodName + " AND \
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
	var productImage = JSON.parse(product.product);
	productImage.image = product.image;

	console.log(productImage);

	var sql = "INSERT INTO products (prod_name, unit_price, prod_cat, arr_date, age_range, prod_image, prod_desc) VALUES\
	(?, ?, ?, ?, ?, ?, ?)";

	dbConn.query(sql, [productImage.name, productImage.price, productImage.category, productImage.arrival, productImage.age, productImage.image, productImage.desc], function(err, result){
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