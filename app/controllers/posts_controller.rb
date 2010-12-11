class PostsController < ApplicationController
  
  def index
    @posts = Post.ordered.published.paginate(:page => params[:page], :per_page => 10)
    expires_in 10.minutes, :public => true
    respond_to do |format|
      format.html
      format.rss
    end
  end
  
  def show
    @post   = Post.find_using_preview_key(params[:id])
    # Post isn't found via the preview key, so don't set the cache header.
    if @post.blank?
      @post = Post.published.find_using_slug!(params[:id])
      fresh_when :last_modified => @post.published_at.utc, :etag => @post, :public => true
    end
    add_title_variables! :post_title => @post.title
    
  end
  
  def archives
    @posts = Post.ordered.published.for_listing.all
    expires_in 1.hour, :public => true
  end
  
  protected
  
  helper_method :summarized_feed?
  def summarized_feed?
    !params[:full]
  end
  
end
