EmergencyDins::Application.routes.draw do
  resources :safe_cooking_temps

 #mount Lockup::Engine, at: '/lockup123'
#  devise_for :users
 # resources :recipes


  # You can have the root of your site routed with "root"
   root 'recipes#index'

  resources :recipes do
    # The id param is passed via js, so we can use a generic route.
    post :sort, on: :collection
  end


get 'make'=> 'recipes#make'
get 'make_cover' => 'recipes#make_cover'
  # Example of regular route:
get 'index2' => 'recipes#index2'
     get 'sub30' => 'recipes#sub30'
     get 'blown' => 'recipes#blown'
     get 'meaty' => 'recipes#meaty'
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
