Eoraptor::Application.routes.draw do |map|
  
  namespace :admin do
    get       '', :as => :dashboard, :to => 'dashboard#index'
    resources :posts
    resources :projects
    resources :pages
  end
  
  root :to => 'posts#index'
  
  get  'contact-me', :to => 'contacts#new', :as => :contact_me
  post 'contact-me', :to => 'contacts#create'
  
  get 'posts/:id', :to => 'posts#show', :as => :post
  get 'archives', :to => 'posts#archives', :as => :post_archives
  
  resources :projects, :only => [:index, :show]
  
  get '/:id', :to => 'pages#show', :as => :page
  
end
