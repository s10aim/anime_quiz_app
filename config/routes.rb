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

  resource :home, controller: :home, only: %i[show]

  namespace :admin do
    root 'top#index'
    resources :animes, except: [:new]
    resources :reports, only: %i[index show edit update]
    namespace :reports do
      resources :quizzes, only: %i[show edit update]
    end
  end

  resources :quizzes do
    collection do
      get 'draft'
    end
    scope module: :quizzes do
      resource :reports, only: %i[new create]
    end
    resource :likes, only: [:create, :destroy]
  end

  resource :descriptions, only: %i[show create]

  resource :plays, only: %i[show] do
    scope module: :plays do
      resource :forward, only: %i[update]
      resource :back, only: %i[update]
    end
  end

  resources :quiz_packages, only: %i[update]

  resource :results, only: %i[show]

  resource :rankings, only: %i[show] do
    scope module: :rankings do
      resource :week, only: %i[show]
      resource :month, only: %i[show]
      resource :anime, only: %i[show update]
    end
  end
end
