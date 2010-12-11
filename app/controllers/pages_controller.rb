class PagesController < ApplicationController
  
  def show
    @page = Page.published.find_using_slug!(params[:id])
    page_title_is @page.title
    fresh_when :last_modified => @page.published_at.utc, :etag => @page, :public => true
  end
  
end
