class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout 'blog'
  
  include TitleEstuary
  
  extend ControllerExt
  uses_controller_extension :translation, :title_estuary
  
  protected
  
  def require_admin
    authenticate_or_request_with_http_basic "Eoraptor Admin" do |username, password|
      SimpleUser.valid_user? username, password
    end
  end
  
end
