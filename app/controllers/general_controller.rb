class GeneralController < ApplicationController
	require 'opentok'
	skip_before_action :verify_authenticity_token
	#before_filter :authenticate_user!

	puts "============ pre general controller"



	def index

		#set default flag, used in tokbox.js to trigger session if someone logged in.
		@goodToGo = "false"

		@ipAddress = request.ip

		@isAdmin = "false"

		@api_key = ENV['api_key']
	    @api_secret = ENV['api_secret']

	    opentok = OpenTok::OpenTok.new @api_key, @api_secret
	    

	    #check if theres an existing session
	    @allSessions = Session.all


	    puts "in here============="


	    #check if logged in, and if admin status is true
		if user_signed_in? && current_user.admin

			@isAdmin = "true"

	    	
	    	puts "------------user is signed in and the admin aswell"

	    	@goodToGo = "true"

	    	#if theres no existing sessions create one
		    if @allSessions.size == 0

		    	puts "----------@allSessions.length == 0"

		    	@session = opentok.create_session :media_mode => :routed
		    	
		    	@session_id = @session.session_id
		    	
		   		@newSession = Session.new

		   		#set values for new DB record
		    	@newSession.session = @session_id
		    	
		    	@newSession.save!
		    	

		    	puts "created new session"
				
		    	
				#create Token
				@numberOfTimesIpIsInIpDb = Ip.where("ipaddy = ?", @ipAddress)

				if @numberOfTimesIpIsInIpDb.size >= 0

					@token = opentok.generate_token @session_id, data: @ipAddress
					
					newIpToSaveInDb = Ip.new(:ipaddy => @ipAddress)
	  				newIpToSaveInDb.save

	    			puts "*****************created new token and saved it to DB"


  				elsif @numberOfTimesIpIsInIpDb.size > 0
  					
  					puts "**Unable to create dual service token ****************"
  				end


				
	    			
				
		    


		  	else

		    	puts "----------@allSessions.length > 0, shows on, Duplicate tab maybe??"

	    	end

	  	
	  	elsif user_signed_in?

	  		@goodToGo = "true"


	  		puts "------------user is signed in and NOT the admin aswell"


		    if @allSessions.size == 0

		    	
	    			
    			puts "-----non admin signed in but no sessions in db, shows off"
				
		    else

		    	puts "-----non admin signed in and session exists in db"
		    	puts "IP address is = "+ @ipAddress

		    	

		    	
		    	#create Token
				@numberOfTimesIpIsInIpDb = Ip.where("ipaddy = ?", @ipAddress)

				if @numberOfTimesIpIsInIpDb.size >= 0

					@session_id = Session.first.session


					puts "SEEEESSSION  " + @session_id

					@token = opentok.generate_token @session_id, data: @ipAddress




					
					newIpToSaveInDb = Ip.new(:ipaddy => @ipAddress)
	  				newIpToSaveInDb.save

	    			puts "*****************created new token and saved it to DB"


  				elsif @numberOfTimesIpIsInIpDb.size < 0
  					
  					puts "**Unable to create dual service token ****************"
  				end
	    	end

    	end


  		puts "past the big logic block"
  		 
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
