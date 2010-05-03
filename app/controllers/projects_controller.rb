class ProjectsController < ApplicationController
  
  def index
    @projects = Project.ordered.published.all
  end
  
  def show
    @project = Project.published.find_using_slug!(params[:id])
    add_title_variables! :project_name => @project.name
  end
  
end