class DashboardsController < UserApplicationController
  def show
    @posts  = Post.page(params[:page]).per(32)
  end
end
