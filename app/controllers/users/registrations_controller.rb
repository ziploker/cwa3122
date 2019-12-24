# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  #respond_to :html, :js
  #GET /resource/sign_up



  def new

    @title = "devise_page"
    super


  end

  
  #POST /resource
  def create
    
    #get all records from local db
    #@pool = Pool.all

    #check if person trying to register is on the list
    #if Pool.exists?(uid: params[:user][:uid])

    @title = "devise_page"

    if User.count == 0
      super
      @user.admin = "true"
      @user.approved = "true"
      @user.save
    else

      super
    end

      

    if params[:user][:avatar] != nil
      puts "there was an avatar"
      @user.avatar.attach(params[:user][:avatar])

    else
      puts "there was NOT an avatar"
    end
    
    #else
      
     # this line was blank already #flash[:error] = "uid not in cwa3122 database"
    #  set_flash_message! :notice, :uid_not_found
    #  redirect_to new_user_registration_path(request.parameters)


     # puts "Halt!!"
    #end

  end

  # GET /resource/edit
   def edit
    @title = "devise_page"
    super
   end

  # PUT /resource
   def update
 

    @title = "devise_page"
     #@user.avatar.purge_later

    

    
    
    
    

    if params[:user][:avatar] != nil
      puts "there was an avatar at update method"

      
      @user.avatar.attach(params[:user][:avatar])


      

    else
      puts "there was NOT an avatar at update method"

    end

    #puts "password is => " + params[:user][:password]
    #puts "passwordC is => " + params[:user][:password_confirmation]
    #user.save!
    super

    
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


  private

  # Notice the name of the method
  def sign_up_params
    params.require(:user).permit(:uid, :first_name, :last_name, :email, :password, :password_confirmation, :avatar, :approved, :admin)
  end


  def account_update_params
    
    params.require(:user).permit(:uid, :first_name, :last_name, :email, :avatar, :approved, :admin)
  end

end
