Blog::Application.routes.draw do
  resources :comments
  
  resources :images
  resources :comments
  resources :products do
    member do
      post 'product_comments'
      post 'product_likes_and_dislikes'
      post 'product_reply_comment'
    end
    collection do
      get 'product_categories'
      post 'update_featured'
      delete 'delete_product_images'
    end
  end
  get '/profile/:id' => 'home#profile', as: "profile"
  get '/search' => 'home#search'
  post '/home/follow' => 'home#user_following'
  get 'home/user' => 'home#user_list'
  post '/user/rating' => 'home#user_ratings'
  get '/home/user_sorted' => 'home#user_sorted_products'
  get '/home/like_sorted' => 'home#like_sorted_products'
  get '/home/product_likes_sorted' => 'home#like_sorted_search_products'
  get '/home/date_sorted' => 'home#date_sorted_products'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
