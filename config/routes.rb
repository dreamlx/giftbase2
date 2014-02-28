Giftbase::Application.routes.draw do
  get '/alipay/done/:order_number' => 'alipay#done', as: :done_alipay
  post '/alipay/notify/:order_number' => 'alipay#notify', as: :notify_alipay
  get '/home/privacy'

  resources :users, only: [] do
    member do
      get 'study_record'
      get 'study_record_chart'
      get 'study_schedule'
      get 'parent'
      post 'parent_add_child'
      post 'child_confirm_parent'
    end
  end

  resources :grades, only: [:index, :show] do
    member do
      post 'purchase'
    end
  end

  resources :stages, only: [:index, :show] do
    member do
      post 'purchase'
    end
  end

  resources :units, only: [:show] do
    member do
      get 'take_exam'
    end
  end

  resources :orders, only: [:index, :show, :create] do
    member do
      post 'pay'
      post 'pay_by_cash'
    end
  end

  resources :answers, only:[:new, :create]

  resources :exams, only: [:new, :create, :show] do
    member do
      get 'score'
    end
  end

  resources :answers, only: [:create]
  
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
        get 'ranking'
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

    end
    
    resources :exams do
      member do
        post :finish_uploading
      end
      collection do
        get  :wrong_answers 
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
    resources :users
    
    resources :question_levels, except: [:show]

    resources :grades do
      resources :pictures, only: [:new, :create, :destroy]
    end

     resources :ranks do
      collection do
        get 'ranking'
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
        post 'move_higher'
        post 'move_lower'
      end
    end

    resources :exams, only: [:index, :show, :new] do
      member do
        post :start_review
        post :finish_review
      end

      collection do
        get :wrong_answers
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
        post 'copy'
      end

      resources :map_places, only: [:new, :create, :destroy]
    end

    resources :questions do
      member do
        get 'do_question'
      end 
    end
    
    resources :reports, only: [:index]

    match '/', to: 'dashboard#index'
  end

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  # scope "/admin" do
  #   resources :users
  # end
  
  root :to => 'home#index'
end