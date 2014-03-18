Revive2::Application.routes.draw do
  resources :types

  root to: 'pages#home'
  get '/help' => 'pages#help'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

  resources :ebay_listings
  resources :etsy_listings
  resource :shopping_cart
  resources :shopping_cart_items, only: [ :destroy ]
  devise_for :users

  filters=%w[needs_cleaning needs_repair needs_photos needs_listing available vintage]

  resources :products do
    resources :uploads
    resources :ebay_listings
    resources :etsy_listings

    collection do
      filters.each do |filter|
        get filter => 'products#index', filter: filter 
      end
    end
    
  end

  resources :uploads do
    collection do
      get :edit_multiple
      put :update_multiple
   end
 end 

Type.all.each do |i|
  resources i.name.underscore.downcase.pluralize.to_sym, controller: 'products', type: i.name do
    collection do
      filters.each do |filter|
        get filter => 'products#index', filter: filter 
      end
    end
  end
end

 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
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
