class PostsController < ApplicationController
  
  caches_page :index, :show, :archives
  
  def index
    @posts = Post.ordered.published.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.rss
    end
  end
  
  def show
    @post = Post.published.find_using_slug!(params[:id])
    add_title_variables! :post_title => @post.title
  end
  
  def archives
    @posts = Post.ordered.published.for_listing.all
  end
  
end