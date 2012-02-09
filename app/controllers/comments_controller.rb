class CommentsController < UserApplicationController
  before_filter :group
  before_filter :post

  def create
    @comment = @post.comments.build(params[:comment])
    @comment.author = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to group_path(@group, :anchor => "comment-#{@comment.id}") }
      else
        format.html { redirect_to group_path(@group, :anchor => "post-#{@post.id}") }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy if @comment.author == current_user
    redirect_to @group
  end

  private

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end

  def post
    @post ||= @group.posts.find(params[:post_id])
  end
end
