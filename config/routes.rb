Rails.application.routes.draw do
  devise_for :users, :controllers => {:passwords => 'users/passwords', :confirmations => 'users/confirmations', :sessions => 'users/sessions', :registrations => 'users/registrations'}
  get '/users/sign_up', to: redirect('/users/sign_in')

  namespace :api do
    namespace :v1 do
      resources :weather, only: :index
      get 'reminders/today', to: 'reminders#today'
      resources :users, only: [:index, :update]
      resources :news, only: [:index]
      resources :notes, only: [:index, :update, :show]
      resources :reminders, only: [:create, :destroy, :update]
      resources :reminder_categories, only: [:index, :show, :create] do
        get 'completed', to: 'reminder_categories#completed'
      end
      resources :decks, only: [:index, :update, :create] do
        resources :definitions, only: [:create]
        resources :definition_titles, only: [:destroy]
        resources :cards, only: [:index, :update, :create] do
          resources :masteries, only: :create
        end
      end
      post 'emails/groups', to: 'emails#groups'
    end
  end

  root 'homes#index'
  get '/flashcards', to: 'homes#index'
  get '/flashcards/study/', to: redirect('/flashcards')
  get '/flashcards/study/:id', to: 'homes#index'
  get '/flashcards/edit/:id', to: 'homes#index'
  get '/flashcards/new', to: 'homes#index'
  get '/notes', to: 'homes#index'
  get '/reminders', to: 'homes#index'
  get '/notes/:id', to: 'homes#index'
  get '/users/profile', to: 'homes#index'
  get '/not-found', to: 'homes#index'
  get '*path', to: redirect('/not-found')
end
