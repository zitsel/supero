Revive2::Application.routes.draw do
  devise_for :users
  resources :products do
    resources :uploads
    member do
      get :ebay
      put :ebay_post
    end
  end
  resources :uploads do
    collection do
      get :edit_multiple
      put :update_multiple

   end
 end 

  resources :shirts, controller: 'products', type: 'Shirt' 
  resources :belts, controller: 'products', type: 'Belt'
  resources :neckwears, controller: 'products', type: 'Neckwear'
  resources :blazers, controller: 'products', type: 'Blazer'
  resources :suits, controller: 'products', type: 'Suit'
  resources :overcoats, controller: 'products', type: 'Overcoat'
  resources :trousers, controller: 'products', type: 'Trouser'
  resources :sweaters, controller: 'products', type: 'Sweater'
  resources :jackets, controller: 'products', type: 'Jacket'
  resources :shoes, controller: 'products', type: 'Shoe'

  root 'products#index'
  
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
