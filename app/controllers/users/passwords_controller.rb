# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  
  # GET /resource/password/new5
   def new
      
     @title = "forgot_password_wrapper"
     super
   end

  # POST /resource/password
   def create
    @title = "forgot_password_wrapper"
     super
   end

  # GET /resource/password/edit?reset_password_token=abcdef
   def edit
    @title = "forgot_password_wrapper"
     super
   end

  # PUT /resource/password
   def update
    @title = "forgot_password_wrapper"
     super
   end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
