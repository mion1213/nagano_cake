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
    
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
  
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get 'confirm'
        post 'confirm'
        get 'complete'
      end
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
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
end
