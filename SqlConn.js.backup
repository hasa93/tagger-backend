var mysql = require('mysql');
var sha1 = require('sha1');

var defaultParams = {
	host: 'localhost',
	user: 'root',
	password: '123',
	database: 'tagger'
};

var sqlConn = function(params){
	this.connParams = params || defaultParams;
};

sqlConn.prototype.init = function(){
	this.connection = mysql.createConnection(this.connParams);
	this.connection.connect(function(err){
		if(err){
			console.log('Connection failed due to: ' + err);
			return;
		}

		console.log('Connection succeeded!');
	});
};

sqlConn.prototype.getProductList = function(callBack){
	var sql = "SELECT * FROM products WHERE discontinued IS FALSE";

	this.connection.query(sql, function(err, rows, fields){
		if(err){
			console.log(err);
			return;
		}
		console.log(rows);
		callBack(rows);
	});
}

sqlConn.prototype.getProductById = function(prodId,callBack){

	var sql = "SELECT * FROM products WHERE prod_id=? AND discontinued IS FALSE";

	this.connection.query(sql, [prodId], function(err, rows, fields){
		if(err){
			console.log(err);
			return;
		}
		console.log(rows);
		callBack(rows);
	});
}

sqlConn.prototype.getProductsByName = function(prodName, callBack){
	var prodName = mysql.escape('%' + prodName + '%');
	var sql = "SELECT * FROM products WHERE prod_name LIKE" + prodName + " AND \
	discontinued IS FALSE";

	this.connection.query(sql, function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

sqlConn.prototype.updateProduct = function(product, callBack){
	var sql = "UPDATE products SET prod_name=?, unit_price=? WHERE prod_id=?";

	this.connection.query(sql, [product.name, product.price, product.id], function(err, result){
		if(err){
			console.log(err);
			return;
		}

		callBack(result);
	});
}

sqlConn.prototype.deleteProduct = function(productId, callBack){
	var sql = "UPDATE products SET discontinued=TRUE WHERE prod_id=?";

	this.connection.query(sql, [productId], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

sqlConn.prototype.insertPurchaseRec = function(receipt){

	for(var i = 0; i < receipt.products.length; i++)
	{
		var product = receipt.products[i];
		console.log(product);

		var sql = "INSERT INTO purchase_records (prod_id, cashier_id, voucher_id, prod_qty)\
		VALUES (?, ?, ?, ?)";

		this.connection.query(sql, [product.prod_id, product.cashier_id, product.voucher_id, product.qty], function(err, result){
			if(err) console.log(err);
			console.log(result);
		});
	}
}

sqlConn.prototype.createVoucher = function(voucher, callBack){
	console.log(voucher);

	var sql = "INSERT INTO voucher (issued_branch, vouch_amount, exp_date)\
	VALUES (?, ?, ?)";

	this.connection.query(sql, [voucher.branch, voucher.amount, voucher.expiry], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

sqlConn.prototype.findVoucher = function(voucher_id, callBack){
	var sql = "SELECT * FROM voucher WHERE vouch_id=?";

	this.connection.query(sql, [voucher_id], function(err, result){
		if(err){
			console.log(err);
			return;
		}
		callBack(result);
	});
}

sqlConn.prototype.deleteVoucher = function(voucher_id, callBack){
	var sql = "DELETE FROM voucher WHERE vouch_id=?";

	this.connection.query(sql, [voucher_id], function(err, result){
		if(err){
			console.log(err);
			return;
		}

		callBack(result);
	});
}

sqlConn.prototype.createLogin = function(user, callBack){
	console.log(user);

	var query = "INSERT INTO logins (uname, passwd, staff_id, cust_id) VALUES (?, ?, ?, ?)";

	this.connection.query(query, [user.uname, user.passwd, user.staff_id, user.cust_id],
		function(err, result){
			if(err) console.log(err);
			result.user = user;
			callBack(result);
	});
}

sqlConn.prototype.authenticateStaff = function(user, callBack){
	console.log(user);

	user.passwd = sha1(user.passwd);

	var sql = "SELECT logins.uname, staff.staff_id, staff.staff_fname, staff.staff_lname, staff.staff_type\
	FROM logins, staff WHERE logins.uname=? AND logins.passwd=? AND logins.staff_id=staff.staff_id";

	this.connection.query(sql, [user.uname, user.passwd], function(err, result){
		if(err){
			callBack({
				status: "ERROR",
				message: err
			})
		}

		console.log(result);

		if(result.length == 1){
			var userProfile = {
				status: "OK",
				uname: user.uname,
				staff_id: result[0].staff_id,
				fname: result[0].staff_fname,
				lname: result[0].staff_lname,
				type: result[0].staff_type
			};

			callBack(userProfile);
			return;
		}

		callBack({
			status: "ERROR",
			message: "Invalid login"
		});
	});
}

sqlConn.prototype.createStaffMember = function(staffMember, callBack){
	staffMember.passwd = sha1(staffMember.passwd);
	var conn = this;

	var sql = "INSERT INTO staff (staff_fname, staff_lname, staff_type, staff_contact)\
		VALUES (?, ?, ?, ?)";

	conn.connection.query(sql, [staffMember.fname, staffMember.lname, staffMember.type, staffMember.contact], 
		function(err, result){
			if(err) console.log(err);
			staffMember.staff_id = result.insertId;
			console.log(staffMember);

			conn.createLogin(staffMember, function(result){
				callBack(result);
			});

	});
}

sqlConn.prototype.createCustomer = function(customer, callBack){
	customer.passwd = sha1(customer.passwd);

	var conn = this;

	var sql = "INSERT INTO customer (cust_fname, cust_lname, cust_cat, cust_contact, cust_addr) \
	VALUES (?, ?, ?, ?, ?)";

	conn.connection.query(sql, [customer.fname, customer.lname, customer.cat, customer.contact, customer.addr],
		function(err, result){
			if(err) console.log(err);
			customer.cust_id = result.insertId;

			conn.createLogin(customer, function(result){
				callBack(result);
			})
		}
	);
}

sqlConn.prototype.searchStaffByName = function(name, callBack){
	console.log("Looking for staff member " + name);
	var name = mysql.escape('%' + name + '%');

	var sql = "SELECT * FROM staff WHERE staff_fname LIKE " + name +" OR staff_lname LIKE " + name;
	console.log(sql);

	this.connection.query(sql, function(err, result){
		if(err) console.log(err);
		callBack(result);
	});
}

sqlConn.prototype.deleteStaffById = function(staffId, callBack){
	var sql = "DELETE FROM staff WHERE staff_id=?";

	this.connection.query(sql, [staffId], function(err, result){
		if(err) console.log(err);
		callBack(result);
	});
}

sqlConn.prototype.updateStaffDetails = function(staffId, staffMember, callBack){
	var sql = "UPDATE staff SET staff_type=?, staff_contact=?, \
	u_name=? WHERE staff_id=?";

	this.connection.query(sql, [staffMember.type, staffMember.contact, staffMember.uname, staffId],
		function(err, result){
			if(err) console.log(err);
			callBack(result);
	});
}

sqlConn.prototype.updateStaffLogin = function(staffId, staffMember, callBack){
	var sql = "UPDATE staff SET u_name=?, u_passwd=? WHERE staff_id=?";

	staffMember.passwd = sha1(staffMember.passwd);

	this.connection.query(sql, [staffMember.uname, staffMember.passwd, staffId],
		function(err, result){
			if(err) console.log(err);
			callBack(result);
	});
}

sqlConn.prototype.getProductByTagId = function(tagId, callBack){
	console.log(tagId);

	var sql = "SELECT products.* FROM products, tag_map WHERE tag_map.prod_id=products.prod_id AND\
	tag_map.tag_uid=?";

	this.connection.query(sql, [tagId], function(err, rows, fields){
		if(err) console.log(err);
		console.log(rows);
		callBack(rows);
	});
}

module.exports = sqlConn;