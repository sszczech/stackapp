class ApplicationController < ActionController::Base
  protect_from_forgery

  def forbidden
    render :template => 'pages/forbidden', :status => :forbidden
  end
end
