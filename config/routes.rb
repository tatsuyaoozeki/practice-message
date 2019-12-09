Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root 'blogs#index'
  resources :blogs do
    resources :comments do
      collection do
        post :confirm
      end
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
