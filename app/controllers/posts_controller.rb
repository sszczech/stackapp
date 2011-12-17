class PostsController < UserApplicationController
  before_filter :group

  def new
    @post = @group.posts.build
  end

  def create
    @post = @group.posts.build(params[:post])
    @post.author = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @group }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def destroy
    @post = @group.posts.find(params[:id])
    @post.destroy if @post.author == current_user
    redirect_to @group
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end
end
