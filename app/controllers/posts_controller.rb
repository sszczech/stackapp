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

  def edit
    @post = @group.posts.find(params[:id])
  end

  def update
    @post = @group.posts.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to group_path(@group, :anchor => "post-#{@post.id}") }
      else
        format.html { render :action => 'edit' }
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
