Rails.application.routes.draw do
  
  

  devise_for :users, 

  	controllers: {
    	registrations: 'users/registrations',
      sessions: 'users/sessions',
    	confirmations: 'confirmations'
    
  	}


  	
  get 'general/deleteSessions' => 'general#deleteSessions', :as => "delete_all_sessions"
  get 'general/deleteSessionsV2' => 'general#deleteSessionsV2', :as => "delete_all_sessionsV2"
  get 'general/deleteSIps' => 'general#deleteIps', :as => "delete_all_ips"
  get 'video/index'
  get 'admins/index' => 'admins#index', :as =>'admins'
  root 'general#index'

  patch 'general/judge' => 'general#judge', :as => "judge"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
