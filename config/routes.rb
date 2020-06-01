Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'sending_destinations', to: 'users/registrations#new_sending_destination'
    post 'sending_destinations', to: 'users/registrations#create_sending_destination'
  end
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:index] do
      collection do
        post 'pay', to: 'purcahse#pay'
        get 'done', to: 'purcahse#done'
      end
    end
  end
  
  resources :users, only: [:show] do
    collection do
      get 'users/mypage', to: "users#mypage"
      get 'users/logout', to: "users#logout"
    end
  end

  resources :cards, only:[:new, :create, :destroy, :show]
end
