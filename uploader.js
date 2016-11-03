var multer = require('multer');
var sha1 = require('sha1');

var storage = multer.diskStorage({
	destination: function(req, file, callBack){
		console.log("Writing file...");
		callBack(null, './thumbs');
	},

	filename: function(req, file, callBack){
		var ext = file.originalname.split('.');
		ext = '.' + ext[ext.length - 1];
		var filename = sha1(file.fieldname + Date.now()) + ext;
		callBack(null, filename);
	}
});

var uploader = multer({ storage: storage }).single('thumb');

module.exports = uploader;