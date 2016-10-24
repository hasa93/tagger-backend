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

	dbConn.query(sql, [voucher.branchId, voucher.amount, voucher.expiry], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

exports.findVoucher = function(voucher_id, callBack){
	var sql = "SELECT voucher.*, branch.branch_name FROM voucher,branch WHERE vouch_id=?\
	AND branch.branch_id = voucher.issued_branch";

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

exports.updateInventoryLevel = function(newLevel, callBack){
	var sql = "SELECT * FROM inventory WHERE branch_id=? AND product_id=?";

	dbConn.query(sql, [ newLevel.branchId, newLevel.prodId ], function(err, result){
		if(err){
			console.log(err);
			return;
		}

		if(result.length == 0){
			console.log('Inerting new...');

			var createLevel = "INSERT INTO inventory VALUE (?, ?, ?)";

			dbConn.query(createLevel, [newLevel.branchId, newLevel.prodId, newLevel.level], function(err, result){
				if(err){
					console.log(err);
					return;
				}
				callBack(result);
			});
		}
		else{
		console.log('Updating...');

		sql = "UPDATE inventory SET product_level=? WHERE branch_id=? AND product_id=?";

		dbConn.query(sql, [newLevel.level, newLevel.branchId, newLevel.prodId], function(err, result){
			if(err){
				console.log(err);
				return;
			}
			callBack(result);
		});
		}
	});
}

exports.createInvoice = function(ticket, callBack){
	var invoiceQuery = "INSERT INTO invoices (invoice_total, voucher_amount, branch_id)\
	VALUES (?, ?, ?)";

	dbConn.query(invoiceQuery, [ticket.total, ticket.voucherAmount, ticket.branchId], function(err, result){
		if(err){
			console.log(err);
			return;
		}

		var invoiceId = result.insertId;

		var salesQuery = "INSERT INTO sales_records VALUES (?, ?, ?)";

		for(var i = 0; i < ticket.products.length; i++){
			var product = ticket.products[i];

			dbConn.query(salesQuery, [product.id, invoiceId, product.qty], function(err, result){
				if(err){
					console.log(err);
					return;
				}
			});
		}

		callBack(result);
	});
}

exports.getAllSales = function(startDate, endDate, callBack){
	var sql = "SELECT DATE(invoices.invoice_date) AS date, SUM(sales_records.qty) AS qty\
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
	var sql = "SELECT DATE(invoices.invoice_date) AS date, SUM(sales_records.qty) AS qty\
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