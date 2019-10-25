class GeneralController < ApplicationController
	require 'opentok'
	#skip_before_action :verify_authenticity_token

	def index

		@ipAddress = request.ip


		@api_key = ENV['api_key']
	    @api_secret = ENV['api_secret']

	    opentok = OpenTok::OpenTok.new @api_key, @api_secret


	    #create session and session ID
    	@session = opentok.create_session :media_mode => :routed
	    	
    	@session_id = @session.session_id


    	#create Token
		if user_signed_in?
				
			@token = opentok.generate_token @session_id, :data => current_user.uid+@ipAddress
			session[:uid] = current_user.uid
			session[:ip] = @ipAddress
			puts "created new token for user with nickname"
		else

			puts "--------++--------------not signed in-----------"


		end












		#current_user.avatar.purge
		if current_user.try(:admin?)
			@pending_users = User.where(approved: false)
			@users = User.all
		end

		

		if user_signed_in?

			@user = current_user
		end




		
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
