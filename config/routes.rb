Eoraptor::Application.routes.draw do |map|
  
  namespace :admin do
    get 'dashboard', :as => :dashboard, :to => 'dashboard#index'
    resources :posts
    resources :projects
  end
  
  root :to => 'posts#index'
  
  get  'contact-me', :to => 'contacts#new', :as => :contact_me
  post 'contact-me', :to => 'contacts#create'
  
  get 'posts/:id', :to => 'posts#show', :as => :post
  get 'archives', :to => 'posts#archives', :as => :post_archives
  
end
