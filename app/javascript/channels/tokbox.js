console.log("top");

$(document).ready(function (){

	console.log("bottom");


	console.log("tokbox js started");


	// replace these values with those generated in your TokBox Account
	var apiKey = "46445792";
	


	
	var ip = "<%= @ipAddress %>";
	var publisher;
    //var streams = [];
    var token = "<%= @token %>";
    var watchers = 0;
	var streamers = 0;
	var api_key = "<%= @api_key %>"
	var session_id = "<%= @session_id %>"




	// (optional) add server code here
	initializeSession();



	// Handling all of our errors here by alerting them
	function handleError(error) {
	  if (error) {
	    alert(error.message);
	  }
	}



	function initializeSession() {
		
		var session = OT.initSession(api_key, session_id);

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
