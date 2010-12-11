Eoraptor::Application.routes.draw do
  
  # devise_for :users

  namespace :admin do
    get       '/', :as => :dashboard, :to => 'dashboard#index'
    resources :posts
    resources :projects
    resources :pages
  end
 
  get '/page-:page', :to => 'posts#index', :as => :post_listing
  root :to => 'posts#index'
  
  get 'posts.rss', :to => 'posts#index', :format => :rss, :as => :post_rss_feed
  get 'posts/full.rss', :to => 'posts#index', :format => :rss, :as => :full_post_rss_feed, :defaults => {:full => true}
  
  get  'contact-me', :to => 'contacts#new', :as => :contact_me
  post 'contact-me', :to => 'contacts#create'
  
  get 'posts/:id', :to => 'posts#show', :as => :post
  get 'archives', :to => 'posts#archives', :as => :post_archives
  
  resources :projects, :only => [:index, :show]
  
  get '/:id', :to => 'pages#show', :as => :page
  
end
