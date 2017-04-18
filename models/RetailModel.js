var dbConn = require('./../sqlConn');

exports.insertPurchaseRec = function(receipt){

	for(var i = 0; i < receipt.products.length; i++)
	{
		var product = receipt.products[i];
		console.log(product);

		var sql = "INSERT INTO purchase_records (prod_id, cashier_id, voucher_id, prod_qty)\
		VALUES (?, ?, ?, ?)";

		dbConn.query(sql, [product.prod_id, product.cashier_id, product.voucher_id, product.qty], function(err, result){
			if(err) console.log(err);
			console.log(result);
		});
	}
}
exports.getAllSales = function(startDate, endDate, callBack){
	var sql = "SELECT DATE(invoices.invoice_date) AS date,\
			   SUM(sales_records.qty) AS qty,\
			   SUM(invoices.invoice_total) AS total\
			   FROM invoices INNER JOIN sales_records ON invoices.invoice_id=sales_records.invoice_id\
			   GROUP BY DATE(invoices.invoice_date)";

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}

		console.log(result);
		filtered = [];
		for(var i = 0; i < result.length; i++){
			if(result[i].date.toJSON() >= startDate && result[i].date.toJSON() <= endDate){
				filtered.push(result[i]);
			}
		}

		callBack(filtered);
	});
}

exports.getSalesById = function(startDate, endDate, prodId, callBack){
	var sql = "SELECT DATE(invoices.invoice_date) AS date,\
			   SUM(sales_records.qty) AS qty,\
			   SUM(invoices.invoice_total) AS total\
			   FROM invoices INNER JOIN sales_records ON invoices.invoice_id=sales_records.invoice_id\
			   WHERE sales_records.product_id=? GROUP BY DATE(invoices.invoice_date)";

	dbConn.query(sql, [prodId], function(err, result){
		if(err){
			console.log(err);
			return;
		}

		filtered = [];
		for(var i = 0; i < result.length; i++){
			if(result[i].date.toJSON() >= startDate && result[i].date.toJSON() <= endDate){
				filtered.push(result[i]);
			}
		}

		callBack(filtered);
	});
}

exports.getMostSoldProducts = function(callBack){
	var sql = "SELECT products.prod_name AS name,\
			   SUM(sales_records.qty) AS qty,\
			   (sales_records.qty * products.unit_price) AS total\
			   FROM products INNER JOIN sales_records\
			   ON products.prod_id = sales_records.product_id WHERE products.discontinued IS FALSE\
			   GROUP BY (sales_records.product_id) ORDER BY SUM(sales_records.qty)\
			   DESC LIMIT 4";

	dbConn.query(sql, function(err, result){
		if(err){
			console.log(err);
			callBack({ status: "ERROR", msg: err });
			return;
		}
		callBack(result);
	});

}

exports.flagProduct = function(prodId, custId, callBack){
	var sql = "INSERT INTO flags (prod_id, cust_id) VALUES (?, ?)";

	dbConn.query(sql, [prodId, custId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.removeFlag = function(prodId, custId, callBack){
	var deflagQuery = "DELETE FROM flags WHERE cust_id=? AND prod_id=?";

	dbConn.query(deflagQuery, [custId, prodId], function(err, result){
		if(err){
			console.log(err);
			callBack({ status: "ERROR", msg: err });
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
