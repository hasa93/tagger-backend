var mysql = require('mysql');
var dbConn = require('../sqlConn');
var fs = require('fs');

var convertToB64 = function(product, callBack){
	product.image = __dirname + '/../thumbs' + product.image;

	fs.readFile(product.image, function(err, file){
		if(err){
			console.log(err);
			product.image = undefined;
			callBack(product);
			return;
		}

		var b64 = new Buffer(file).toString('base64');
		product.image = b64;
		callBack(product);
	});
}

exports.getCustomerPreferences = function(product, custId, callBack){
	var customerQuery = "SELECT IFNULL((SELECT cust_id FROM flags WHERE cust_id = ? AND prod_id = ?), null) AS flag,\
			 IFNULL((SELECT prod_rating FROM ratings WHERE cust_id = ? AND prod_id=?), null) AS ratings";

	dbConn.query(customerQuery, [custId, product.id, custId, product.id], function(err, prefs){
	 	if(err){
	 		console.log(err);
	 		callBack({ status: "ERROR", msg: err });
	 		return;
		}

		console.log(product);

 		product.ratings = prefs[0].ratings;
 		product.flag = prefs[0].flag;
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

exports.getProductsByName = function(prodName, callBack){
	var prodName = mysql.escape('%' + prodName + '%');
	var sql = "SELECT prod_id as id,\
					  prod_name AS name,\
					  unit_price AS price,\
					  prod_cat AS cat,\
					  DATE(arr_date) AS arrival,\
					  age_range AS age,\
					  prod_image AS image,\
					  prod_desc AS descr\
					  FROM products WHERE prod_name LIKE" + prodName + " AND \
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
	var tagQuery = "INSERT INTO tag_map VALUE (?, ?) ON DUPLICATE KEY\
	UPDATE prod_id=?";

	dbConn.query(tagQuery, [productTag.uid, productTag.prodId, productTag.prodId], function(err, result){
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
	prod_cat=?, arr_date=?, prod_image=?, prod_desc=? WHERE prod_id=?";

	dbConn.query(sql, [delta.name, delta.price, delta.age, delta.cat, delta.arrival, delta.image, delta.descr, prodId], function(err, result){
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

exports.getMostRecentProducts = function(count, category, callBack){
	console.log(parseInt(count));
	var sql = "SELECT prod_id AS id,\
					  prod_name AS name,\
					  unit_price AS price,\
					  arr_date AS date,\
					  age_range AS age,\
					  prod_image AS image,\
					  prod_desc AS descr\
					  FROM products WHERE prod_cat=?\
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
	var sql = "SELECT * FROM flags WHERE cust_id=?";

	dbConn.query(sql, [custId], function(err, result){
		if(err || result.length === 0){
			console.log(err);
			return;
		}

		var prodId = result[0].prod_id;

		exports.getProductById(prodId, callBack);
	});
}
