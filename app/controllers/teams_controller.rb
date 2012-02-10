class TeamsController < UserApplicationController

  before_filter :group
  before_filter :team, :only => [:show, :edit, :update, :destroy]

  def new
    @team = Team.new
    forbidden unless @group.teacher == current_user
  end

  def show
    @post = Post.new
    respond_to do |format|
      if @group.teacher == current_user || @team.users.include?(current_user)
        format.html
      else
        format.html { forbidden }
      end
    end
  end

  def create
    @team = @group.teams.build(params[:team])
    @team.group = @group
    respond_to do |format|
      if @group.teacher == current_user && @team.save
        format.html { redirect_to [@group, @team] }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @group.teacher == current_user && @team.update_attributes(params[:team])
        format.html { redirect_to [@group, @team] }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @team.destroy if @group.teacher == current_user
    redirect_to @group
  end

  private

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end

  def team
    @team ||= @group.teams.find(params[:id])
  end
end
