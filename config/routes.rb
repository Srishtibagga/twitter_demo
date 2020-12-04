Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#new'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:follow, :unfollow] do
  	member do
  		post :follow
  		post :unfollow
  	end
  end
	  
  resources :tweets do
    resources :likes
    resources :comments
    resources :retweets
      collection do
        get :my_tweets
      end
  end
	end
