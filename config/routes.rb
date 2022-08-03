Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root 'top#index'

  namespace :admin do
    root 'top#index'
    resources :animes, except: [:new]
  end

  resources :quizzes do
    collection do
      get 'draft'
    end
  end

  resource :descriptions, only: %i[show]
  resource :plays, only: %i[show create]
  resources :quiz_packages, only: %i[update]
end
