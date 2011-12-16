class PostsController < UserApplicationController
  before_filter :group

  def create
    @post = @group.posts.build(params[:post])
    @post.author = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @group }
      else
        format.html { redirect_to @group }
      end
    end
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end
end
