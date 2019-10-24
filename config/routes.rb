Rails.application.routes.draw do
  
  

  devise_for :users, 

  	controllers: {
    	registrations: 'users/registrations',
      sessions: 'users/sessions',
    	confirmations: 'confirmations'
    
  	}

  	

  get 'video/index'
  get 'admins/index' => 'admins#index', :as =>'admins'
  root 'general#index'

  patch 'general/judge' => 'general#judge', :as => "judge"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
