Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :api do
		namespace :v1 do
			post 'signup', to: 'sessions#create'
			post 'login', to: 'sessions#login'
			
			resources :users, only: [:update] do
        collection do
          get 'profile'
        end
			end
			
		end
	end
end
