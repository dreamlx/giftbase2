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

    resources :credit_line_items

    resource :profiles do
      collection do 
        post :upload_avatar
      end
    end
    
    resources :ranks do
      collection do
        post 'ranking'
      end
    end

    resources :grades

    resources :stages do
      collection do
        get 'mine'
      end

      member do
        post 'purchase'
      end

      member do
        post 'purchase'
      end
    end
    
    resources :exams do
      member do
        post :finish_uploading
      end
      collection do
        post  :wrong_answers 
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
    end

     resources :ranks do
      member do
        post :ranking
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
    end

    resources :exams, only: [:index, :show] do
      member do
        post :start_review
        post :finish_review
        post :wrong_answers
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

  scope "/admin" do
    resources :users
  end
  
  root :to => 'home#index'
end
