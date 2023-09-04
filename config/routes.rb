Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    resources :items, only: [:index, :show]
      namespace :admin do
        resources :items, only: [:index, :new, :create, :show, :edit, :update]
      end
    
  
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  
    resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
      namespace :admin do
        resources :orders, only: [:update, :show]
      end
  
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    
    root to: "homes#top"
    get 'home/about' => 'homes#about' , as: "about"
  end
  
  namespace :public do
    get '/customers/profile' => 'customers#show'
    get '/customers/profile/edit' => 'customers#edit'
    patch '/customers/profile' => 'customers#update'
    get  '/customers/profile/check' => 'customers#check'
    patch  '/customers/profile/withdraw' => 'customers#withdraw'
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    root to: "homes#top"
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
  end
end
