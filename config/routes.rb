Giftbase::Application.routes.draw do
  get '/alipay/done/:order_number' => 'alipay#done', as: :done_alipay
  post '/alipay/notify/:order_number' => 'alipay#notify', as: :notify_alipay

  resources :stages, only: [:index, :show] do
    member do
      post 'purchase'
    end
  end
  
  resources :orders, only: [:index, :show, :create] do
    member do
      post 'pay'
    end
  end
  
  resources :credits, only: [:index]

  namespace :api do
    resource :credit

    resource :profile
    
    resources :grades
    
    resources :stages do
      collection do
        get 'mine'
      end
    end
    
    resources :exams do
      member do
        post :finish_uploading
      end

      resources :answers, only: [:update, :show]
    end
    
    resources :units, only: [:index, :show] do
      collection do
        get 'mine'
      end
      
      resources :question_groups, only: [:index, :show] do
        resources :question_line_items, only: [:index, :show]
      end
    end
  end

  namespace :admin do
    resources :grades do
      resources :pictures, only: [:new, :create, :destroy]
      member do
        post 'ranking'
      end
    end
    
    resources :credit_line_items, only: [:index, :show] do
      collection do
        get 'with_order'
        get 'with_stage'
      end
    end

    resources :orders, only: [:index, :show]
    
    resources :stages do
      resources :map_places, only: [:new, :create, :destroy]
      member do
        post 'ranking'
      end
    end

    resources :exams, only: [:index, :show] do
      member do
        post :start_review
        post :finish_review
      end

      get 'question_groups/:question_group_id/question_line_items/:question_line_item_id/review' => 'reviews#show', as: 'review'
      put 'question_groups/:question_group_id/question_line_items/:question_line_item_id/review' => 'reviews#update'
    end
    
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

      member do
        post 'update_by_ajax'
        get  'order_by_point'
      end
      resources :map_places, only: [:new, :create, :destroy]
    end

    resources :questions
    
    resources :reports, only: [:index]

    match '/', to: 'dashboard#index'
  end

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  root :to => 'home#index'
end
