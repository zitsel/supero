Revive2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'pages#home'
  get '/help' => 'pages#help'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  get '/alterations' => 'pages#alterations'
  get '/garment_repair' => 'pages#garment_repair'
  get '/footwear_repair' => 'pages#footwear_repair'
  get '/leather_repair' => 'pages#leather_repair'
  get '/measurement_fit' => 'pages#measurement_fit'
  get '/quality_garments' => 'pages#quality_garments'
  get '/quality_footwear' => 'pages#quality_footwear'
  get '/careers' => 'pages#careers'
  get '/faq' => 'pages#faq'
  get '/returns' => 'pages#returns'
  get '/privacy' => 'pages#privacy'




  resource :shopping_cart
  resources :shopping_cart_items, only: [ :destroy ]
  devise_for :users

  resources :products 
  resources :orders


  Category.all.each do |i|
    resources i.symbolize, controller: 'products', type: i.name do

  end
end
  namespace :admin do
  Category.all.each do |i|
    resources i.symbolize, controller: 'products', type: i.name
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
