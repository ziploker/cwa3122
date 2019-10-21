class AdminsController < ApplicationController

	


	def	index

		@title = "admin_page"

		#current_user.avatar.purge
		if current_user.try(:admin?)
			@pending_users = User.where(approved: false)
			@users = User.all
		end

		

		if user_signed_in?

			@user = current_user
		end


	end







	









end
