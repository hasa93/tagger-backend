var queu = { all: [] };

exports.addToMessageQueue = function(branchName, message){
	if(branchName == undefined || branchName == null || branchName === ""){
		return;
	}

	console.log(branchName);

	if(!(branchName in queu)){
		console.log("Adding new branch...");
		queu[branchName] = [];
	}

	queu[branchName].push(message);
	console.log(queu);
	return;
}

exports.getMessageQueue = function(branchName){
	if(branchName == undefined || branchName == null || branchName === ""){
		return;
	}

	if(branchName in queu){
		return { all: queu["all"], branch: queu[branchName] };
	}

	return [];
}
