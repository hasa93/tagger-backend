var express = require('express');
var retailModel = require('../models/RetailModel');
var router = express.Router();
var authenticator = require('./authenticator');

router.post('/insert/purchase', authenticator.authenticateStaff, function(req, res){
	var receipt = req.body;
	retailModel.insertPurchaseRec(receipt);
});

router.post('/create/voucher', authenticator.authenticateStaff, function(req, res){
	var voucher = req.body;
	retailModel.createVoucher(voucher, function(result){
		res.json(result);
	});
});

router.get('/find/voucher/:id', authenticator.authenticateStaff, function(req, res){
	retailModel.findVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.get('/find/voucher/cust/:contact', authenticator.authenticateToken, function(req, res){
	var contact = req.params.contact;

	retailModel.getVoucherByCustomer(contact, function(result){
		res.json(result);
	});
});

router.post('/claim/voucher/:id', authenticator.authenticateStaff, function(req, res){
	retailModel.claimVoucher(req.params.id, function(result){
		res.json(result);
	});
});

router.post('/inventory/update', authenticator.authenticateStaff, function(req, res){
	var product = req.body;
	retailModel.updateInventoryLevel(product, function(result){
		res.json(result);
	});
});

router.post('/create/invoice', authenticator.authenticateStaff, function(req, res){
	var ticket = req.body;
	retailModel.createInvoice(ticket, function(result){
		res.json(result);
	})
});

router.post('/stat/sales/all', authenticator.authenticateAdmin, function(req, res){
	var dateRange = req.body;

	retailModel.getAllSales(dateRange.start, dateRange.end, function(result){
		res.json(result);
	})
});

router.post('/stat/sales/id/:id', authenticator.authenticateAdmin, function(req, res){
	var dateRange = req.body;
	var prodId = req.params.id;

	retailModel.getSalesById(dateRange.start, dateRange.end, prodId, function(result){
		res.json(result);
	})
});

router.post('/flag', function(req, res){
	var flag = req.body;

	retailModel.flagProduct(flag.prodId, flag.custId, function(result){
		res.json(result);
	});
});

router.post('/flag/remove', function(req, res){
	var flag = req.body;

	retailModel.removeFlag(flag.prodId, flag.custId, function(result){
		res.json(result);
	});
});

router.post('/voucher/transfer', function(req, res){
	var transfer = req.body;

	retailModel.transferVoucher(transfer.voucherId, transfer.recvContact, function(result){
		res.json(result);
	});
});

module.exports = router;