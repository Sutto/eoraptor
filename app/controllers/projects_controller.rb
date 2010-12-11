class ProjectsController < ApplicationController
  
  def index
    @projects = Project.ordered.published.all
    expires_in 10.minutes, :public => true
  end
  
  def show
    @project = Project.published.find_using_slug!(params[:id])
    add_title_variables! :project_name => @project.name
    fresh_when :last_modified => @project.published_at.utc, :etag => @project, :public => true
  end
  
end