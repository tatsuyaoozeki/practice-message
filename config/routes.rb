Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'users/index'
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root 'blogs#index'
  resources :blogs do
    collection do
      post :confirm
    end
    resources :comments do
    end
  end

  resources :users, only: [:index, :show] do
    member do
      get :following
      get :followers
    end
  end

  resources :conversations do
    resource :messages do
    end
  end 

  resources :relationships, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
