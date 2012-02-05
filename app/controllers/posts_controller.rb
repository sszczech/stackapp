class PostsController < UserApplicationController
  before_filter :group
  before_filter :team

  def new
    @post = @group.posts.build
  end

  def create
    if @team
      @post = @team.posts.build(params[:post])
      @post.group = @group
    else
      @post = @group.posts.build(params[:post])
    end
    @post.author = current_user
    respond_to do |format|
      if @post.save
        if @team
          format.html { redirect_to [@group, @team] }
        else
          format.html { redirect_to @group }
        end
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        if @post.postable.is_a?(Team)
          format.html { redirect_to group_team_path(@group, @post.postable, :anchor => "post-#{@post.id}") }
        else
          format.html { redirect_to group_path(@group, :anchor => "post-#{@post.id}") }
        end
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post.author == current_user
    if @post.postable.is_a?(Team)
      redirect_to [@group, @post.postable]
    else
      redirect_to @group
    end
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end

  def team
    @team ||= @group.teams.find(params[:team_id]) if params.has_key?(:team_id)
  end
end
