Eoraptor::Application.routes.draw do |map|
  root :to => 'posts#index'
  
  get 'posts/:id', :to => 'posts#show', :as => :post
  get 'archives', :to => 'posts#archives', :as => :post_archives
  
end
