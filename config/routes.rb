Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'authenticate', to: 'authentication#authenticate'
  resources :users, only: %i[create show]
  resources :todos do
    resources :items
  end
end
