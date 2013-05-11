Giftbase::Application.routes.draw do
  namespace :api do
    resources :exams
    
    resources :units, only: [:index, :show] do
      resources :question_groups, only: [:index, :show] do
        resources :question_line_items, only: [:index, :show]
      end
    end
  end

  namespace :admin do
    resources :exams, only: [:index, :show]
    
    resources :units do
      resources :question_groups, except: [:index] do
        resources :question_line_items, only: [:create, :update, :destroy] do
          member do
            post 'move_higher'
            post 'move_lower'
          end
        end

        member do
          post 'move_higher'
          post 'move_lower'
          post 'add_question'
          post 'remove_question'
        end
      end
    end

    resources :questions
    
    resources :reports, only: [:index]

    match '/', to: 'dashboard#index'
  end

  devise_for :users

  root :to => 'home#index'
end
