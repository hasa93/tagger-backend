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

exports.createVoucher = function(voucher, callBack){
	console.log(voucher);

	var sql = "INSERT INTO voucher (issued_branch, vouch_amount, exp_date)\
	VALUES (?, ?, ?)";

	dbConn.query(sql, [voucher.branch, voucher.amount, voucher.expiry], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.findVoucher = function(voucher_id, callBack){
	var sql = "SELECT * FROM voucher WHERE vouch_id=?";

	dbConn.query(sql, [voucher_id], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.claimVoucher = function(voucher_id, callBack){
	var sql = "DELETE FROM voucher WHERE vouch_id=?";

	dbConn.query(sql, [voucher_id], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}