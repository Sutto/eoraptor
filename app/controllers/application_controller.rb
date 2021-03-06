class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout 'blog'
  
  include TitleEstuary
  
  extend ControllerExt
  uses_controller_extension :translation, :title_estuary
  
  protected
  
  def require_admin
    authenticate_user!
  end
  
  def expires_in(*args)
    super unless flash[:alert].present? || flash[:notice].present?
  end
  
end
