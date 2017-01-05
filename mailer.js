var mailer = require('gmail-send');
var config = require('./config');

exports.sendResetToken =  function(mail, token){
	var resetLink = config.baseUrl + '/login/reset/' + token;
	console.log(resetLink);

	mailer({
		user: 'jogeggbert@gmail.com',
		pass: 'xejtzamsxabzvopj',
		to: '"User" <' + mail + '>',
		subject: 'Password reset token',
		html: 'You are receiving this mail because you requested a password reset <br> Please follow the link below to complete the reset process:<br><br> ' + resetLink + '<br> <b> (Note: Please disregard this mail if you have not requested a password reset) </b>'
	})(function(err, res){
		if(err){
			console.log(err);
		}

		console.log(res);
	})
}