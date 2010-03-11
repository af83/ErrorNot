class SameErrorsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :load_error
  before_filter :load_project, :only => [:show]

  def show
    @error = @root_error.same_errors.find(params[:id])
    unless @error
      render_404
    else
      render 'errors/show'
    end
  end

  def load_error
    @root_error = Error.find(params[:error_id])
    render_401 unless @root_error.project.member_include?(current_user)
  end

  def load_project
    @project = Project.find!(params[:project_id])
    render_401 unless @project.member_include?(current_user)
  end

end
