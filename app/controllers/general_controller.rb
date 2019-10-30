class GeneralController < ApplicationController
	require 'opentok'
	#skip_before_action :verify_authenticity_token
	#before_filter :authenticate_user!

	puts "============ pre general controller"



	def index

		#set default flag, used in tokbox.js to trigger session if someone logged in.
		@goodToGo = "false"

		@ipAddress = request.ip


		@api_key = ENV['api_key']
	    @api_secret = ENV['api_secret']

	    opentok = OpenTok::OpenTok.new @api_key, @api_secret
	    

	    #check if theres an existing session
	    @allSessions = Session.all


	    puts "in here============="


	    #if theres no existing sessions create one

	    if user_signed_in? && current_user.admin

	    	
	    	puts "------------user is signed in and the admin aswell"

	    	@goodToGo = "true"


		    if @allSessions.length == 0

		    	puts "----------@allSessions.length == 0"

		    	@session = opentok.create_session :media_mode => :routed
		    	
		    	@session_id = @session.session_id
		    	
		   		@newSession = Session.new

		   		#set values for new DB record
		    	@newSession.session = @session_id
		    	
		    	@newSession.save!
		    	

		    	puts "created new session"
				
		    	
				#create Token
				
					
				@token = opentok.generate_token @session_id, data: @ipAddress

				session[:uid] = current_user.uid
				session[:ip] = @ipAddress
	    			
    			puts "created new token"
				
		    


		  	else

		    	puts "----------@allSessions.length > 0, shows on"

	    	end

	  	
	  	elsif user_signed_in?

	  		@goodToGo = "true"


	  		puts "------------user is signed in and NOT the admin aswell"


		    if @allSessions.length == 0

		    	
	    			
    			puts "-----non admin signed in but no sessions in db, shows off"
				
		    else

		    	puts "-----non admin signed in and session exists in db"
		    	puts "IP address is = "+ @ipAddress

		    	@session_id = Session.first

		    	
		    	@numberOfTimesIpIsInConnectDb = Ip.where("ipaddy = ?", @ipAddress)






		    	
		    	
		    	
		    	
		   		

		   		
				#create Token
				if @numberOfTimesIpIsInConnectDb.length == 0
					
					@token = opentok.generate_token @session_id, data: @ipAddress
					session[:uid] = current_user.uid
					session[:ip] = @ipAddress
		    			
	    			puts "created new token"
    			else
    				puts "only 1ipallowed"

				end
	    	end

    	end


  		puts "neither one ?????????????????????????"
  		 
		if user_signed_in?
			puts "user is signed in"
		else
			puts "user aint signed in"
		end

		if current_user == nil

			puts " current user is nil" 	
		else

			puts  "current_user.admin? == "+current_user.admin.to_s
		end
  	end


  	def handle_connectionCreated(event)

	  puts "==================hanble connection crated action Starting"
	  
	  tokenData = params[:connection][:data]

	 

	  #puts "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin hcc event is " + params[:connection][:id]


	  

	  newIpToSaveInDb = Ip.new(:ip => ipString)
	  newIpToSaveInDb.save
	  puts "saved " + tokenData + " to DB"
	end

	def handle_connectionDestroyed(event)
	  
	  #tokenData = params[:connection][:data]

	  #ipString = tokenData.partition('@').last


	  #ipSearchResult = Connect.where("ip = ?", ipString)

#	  if ipSearchResult.length > 0
#
#
  	puts "IP(s) have been purged**************not"
#	  	ipSearchResult.destroy_all
#	  else
#	  	puts "NO IP(s) have been harmed in the making of the notice********"
 # 	  end

	end


	def judge

		puts "welcome to judge method in the general controller"
		

	        @usr = User.find(params[:id])

	        if params[:approved] == "true"

	        	puts "user requesting true status"
	        
	        	@usr.update_attribute(:approved, "true")
        	else

        		puts "user requesting false status"

	        	@usr.update_attribute(:approved, "false")

    		end
	        
	        if  @usr.save
	           redirect_to root_path, :notice => "Successfully changed stat."
	           puts "just finished in general#judge"
	        else
	            render 'index' # Any action here, index for example
	            puts "  diddwnt mke the cut;;;;;;;;;;;;;;;;;;;;"
	        end
          



	end


end
