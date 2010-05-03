class PagesController < ApplicationController
  
  def show
    @page = Page.published.find_using_slug!(params[:id])
    page_title_is @page.title
  end
  
end
