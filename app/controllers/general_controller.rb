class GeneralController < ApplicationController
	require 'opentok'
	skip_before_action :verify_authenticity_token
	#before_filter :authenticate_user!

	



	def index

		@showDeleteSessionInsteadOfStartPublishing = "false"

		#set default flag, used in tokbox.js to trigger initalSession() if flag = true.
		@goodToGo = "false"

		
		#used at the end of tokbox.js, if false then start initalSession() automatically when user signes in
		@isAdmin = "false"

		@ipAddress = request.ip

		@api_key = ENV['api_key']
	    @api_secret = ENV['api_secret']

	    
	    opentok = OpenTok::OpenTok.new @api_key, @api_secret
	    

	    @allSessions = Session.all


	    #check if logged in, and if admin status is true
		if user_signed_in? && current_user.admin

			puts "------------Admin user signed in"

			@isAdmin = "true"
			@goodToGo = "true"

	    	
	    	
	    	#if admin logged in, and if theres no existing sessions, create one
		    if @allSessions.size == 0

		    	puts "----------Admin logged in, and no sessions exist."

		    	@session = opentok.create_session :media_mode => :routed
		    	
		    	@session_id = @session.session_id
		    	
		   		@newSession = Session.new

		   		
		    	@newSession.session = @session_id
		    	
		    	@newSession.save!
		    	

		    	puts "***********Admin logged in, no sessions existed so created new session and save to db"
				



				#3#temporarily, ALWAYS create token
				#@token = opentok.generate_token @session_id, data: @ipAddress
					
				#newIpToSaveInDb = Ip.new(:ipaddy => @ipAddress)
  				#newIpToSaveInDb.save

    			#puts "*****************created new token and saved ip to DB"
		    	
				


				#create Token if user is not already logged in.
				@numberOfTimesIpIsInIpDb = Ip.where("ipaddy = ?", @ipAddress)

				if @numberOfTimesIpIsInIpDb.size == 0

					@token = opentok.generate_token @session_id, data: @ipAddress
					
					newIpToSaveInDb = Ip.new(:ipaddy => @ipAddress)
	  				#newIpToSaveInDb.save

	    			puts "*****************created new token and saved it to DB"


  				elsif @numberOfTimesIpIsInIpDb.size > 0
  					
  					puts "**Unable to create dual service token ****************"
  				end

			

			else

		    	puts "----------@allSessions.length > 0, shows on, Duplicate tab maybe??"
		    	@showDeleteSessionInsteadOfStartPublishing = "true"

	    	end

	  	
	  	#check if user logged in
	  	elsif user_signed_in? && current_user.admin == false

	  		puts "----------non-Admin user logged in."

	  		@goodToGo = "true"


	  		if @allSessions.size == 0

		    	puts "-----non admin signed in but no sessions in db, shows off"
				
		    else

		    	puts "-----non admin signed in and session exists in db"
		    	puts "IP address is = "+ @ipAddress

		    	

		    	@session_id = Session.first.session

		    	#temporarily, ALWAYS create token
				#@token = opentok.generate_token @session_id, data: @ipAddress
					
				#newIpToSaveInDb = Ip.new(:ipaddy => @ipAddress)
  				#newIpToSaveInDb.save

    			#puts "***********created new token and saved ip to DB"
    			#puts "***********non-Admin user logged in, sessions did exist so pulled existing session ID from db"





		    	#create Token
				@numberOfTimesIpIsInIpDb = Ip.where("ipaddy = ?", @ipAddress)

				if @numberOfTimesIpIsInIpDb.size == 0

					

					@token = opentok.generate_token @session_id, data: @ipAddress

					newIpToSaveInDb = Ip.new(:ipaddy => @ipAddress)
	  				#newIpToSaveInDb.save

	    			puts "*****************created new token and saved it to DB"


  				elsif @numberOfTimesIpIsInIpDb.size > 0
  					
  					puts "**Unable to create dual service token ****************"
  				end
	    	end

    	end


  		
  		
  		if user_signed_in?
			puts "user is signed in"
		else
			puts "user aint signed in"
		end

		if current_user == nil

			puts " ....and current user is nil" 	
		else

			puts  " ....current_user.admin? == "+current_user.admin.to_s
		end
  	end


  	def deleteSessions

  		allSessions = Session.all

  		allSessions.delete_all

  		redirect_to admins_path



	end


	def deleteIps

  		allIps = Ip.all

  		allIps.delete_all

  		redirect_to admins_path



	end

	def deleteSessionsV2
		
		puts "Welcome to DeleteSessionsV2 path, you will remain in the general controller"
		allSessions = Session.all

  		allSessions.delete_all

  		redirect_to root_path



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
