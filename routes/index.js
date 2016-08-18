var express = require('express');
var jwt = require('jsonwebtoken');
var sqlConn = require('./../SqlConn');
var config = require('./../config');
var router = express.Router();

var conn = new sqlConn(config.db);
conn.init();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/authenticate', function(req, res){
	var token = req.body.token;

	jwt.verify(token, config.secret, function(err, payload){
		if(err){
			res.json({
				status: "ERROR",
				message: err
			});
			return;
		}

		res.json({
			status: "OK",
			payload: payload
		});
	});
});

router.post('/login/staff', function(req, res){

	var user = req.body;

	var issueToken = function(payload){
		jwt.sign(payload, config.secret, { issuer: 't35-api'}, function(err, token){
			if(err){
				res.json({
					status: "ERROR",
					message: err
				});
				return;
			}

			res.json({
				status: "OK",
				token: token,
				profile: payload
			});
		});
	}

	conn.authenticateStaff(user, function(profile){
		if(profile.status === 'ERROR'){
			res.json(profile);
			return;
		}

		issueToken(profile);
	});
});

router.get('/products', function(req, res){
	conn.getProductList(function(rows){
		res.json(rows);
	});
});

router.get('/get/products/:name', function(req, res){
	conn.getProductsByName(req.params.name, function(result){
		res.json(result);
	});
});

router.post('/delete/product/:id', function(req, res){
	conn.deleteProduct(req.params.id, function(result){
		res.json(result);
	});
});

router.get('/product/:prodId', function(req, res){
	var prodId = req.params.prodId;
	conn.getProductById(prodId, function(rows){
		res.json(rows);
	});
});

router.get('/product/uid/:uid', function(req, res){
	var tagId = req.params.uid;
	console.log(tagId);
	conn.getProductByTagId(tagId, function(rows){
		res.json(rows);
	});
});

router.post('/insert/purchase', function(req, res){
	var receipt = req.body;
	conn.insertPurchaseRec(receipt);
});

router.post('/create/staff', function(req, res){
	var staffMember = req.body;

	conn.createStaffMember(staffMember, function(result){
		result.staffMember = staffMember;
		res.json(result);
	})
});

router.post('/create/customer', function(req, res){
	var customer = req.body;

	conn.createCustomer(customer, function(result){
		result.customer = customer;
		res.json(result);
	});
});

router.get('/get/staff/:name', function(req, res){
	var name = req.params.name;

	conn.searchStaffByName(name, function(result){
		res.json(result);
	});
});

router.get('/delete/staff/:id', function(req, res){
	var staffId = req.params.id;

	conn.deleteStaffById(staffId, function(result){
		res.json(result);
	})
});

router.post('/update/staff/details/:id', function(req, res){
	var staffMember = req.body;
	var staffId = req.params.id;

	conn.updateStaffDetails(staffId, staffMember, function(result){
		res.json(result);
	});
});

router.post('/update/staff/logins/:id', function(req, res){
	var staffMember = req.body;
	var staffId = req.params.id;

	conn.updateStaffLogin(staffId, staffMember, function(result){
		res.json(result);
	});
});

router.post('/create/voucher', function(req, res){
	var voucher = req.body;

	conn.createVoucher(voucher, function(result){
		res.json(result);
	});
});

router.get('/get/voucher/:id', function(req, res){
	conn.findVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/delete/voucher/:id', function(req, res){
	conn.deleteVoucher(req.params.id, function(result){
		res.json(result);
	});
});

module.exports = router;