console.log("top");

$(document).ready(function (){

	console.log("bottom");


	console.log("tokbox js started");


	// replace these values with those generated in your TokBox Account
	var apiKey = "46445792";
	var sessionId = "1_MX40NjQ0NTc5Mn5-MTU3MTk2MDU5NTgyMH5wOW4ycnlqM3lvOVBYdkk0Vk53TmoxbHB-fg";
	var token = "T1==cGFydG5lcl9pZD00NjQ0NTc5MiZzaWc9Yzk5M2RhZGM4NTQ1YjVlODE4MjcxOTA3N2VmNzUyYTc3MmE2ZTJhMTpzZXNzaW9uX2lkPTFfTVg0ME5qUTBOVGM1TW41LU1UVTNNVGsyTURVNU5UZ3lNSDV3T1c0eWNubHFNM2x2T1ZCWWRrazBWazUzVG1veGJIQi1mZyZjcmVhdGVfdGltZT0xNTcxOTYwNjQxJm5vbmNlPTAuMjc5NjQ3OTEzMDgzODk1MzYmcm9sZT1wdWJsaXNoZXImZXhwaXJlX3RpbWU9MTU3MTk2NDIzOSZpbml0aWFsX2xheW91dF9jbGFzc19saXN0PQ==";

	// (optional) add server code here
	initializeSession();



	// Handling all of our errors here by alerting them
	function handleError(error) {
	  if (error) {
	    alert(error.message);
	  }
	}



	function initializeSession() {
		
		var session = OT.initSession(apiKey, sessionId);

		// Subscribe to a newly created stream
		session.on('streamCreated', function(event) {
			session.subscribe(event.stream, 'subscriber', {
			insertMode: 'append',
			width: '100%',
			height: '100%'
			}, handleError);
		});

		
		// Create a publisher
		var publisher = OT.initPublisher('publisher', {
			insertMode: 'append',
			width: '100%',
			height: '100%'
		}, handleError);

		
		// Connect to the session
		session.connect(token, function(error) {
			// If the connection is successful, publish to the session
			if (error) {
				handleError(error);
			} else {
				ssession.publish(publisher, handleError);
			}
		});
	}

});
