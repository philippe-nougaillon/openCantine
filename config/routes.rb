OpenCantine3::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'admin#signin'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  controller :familles do
    #get :autocomplete_famille_nom, :on => :collection
    get 'familles/autocomplete'=> :autocomplete 
  end

  resources :familles
  resources :todos
  resources :blogs
  resources :vacances
  resources :villes
  resources :facture_chronos
  resources :mairies
  resources :factures
  resources :paiements
  resources :tarifs
  resources :classrooms
  resources :prestations 
  resources :enfants
  resources :users
  resources :upload
  resources :logs
  
  match 'admin' => 'admin#signin'
  match 'nouveau' => 'villes#nouveau_compte', :as => :nouveau
  match 'presence' => 'prestations#new_manual_classroom', :as => 'new_manual_classroom'
  
  match '/' => 'familles#index'
  match '/:controller(/:action(/:id))'

  post "admin/import_do", to: 'admin#import_do'

end
