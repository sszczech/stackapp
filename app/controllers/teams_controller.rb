class TeamsController < UserApplicationController

  before_filter :group

  def new
    @team = Team.new
  end

  def show
    @team = @group.teams.find(params[:id])
    @post = Post.new
  end

  def create
    @team = @group.teams.build(params[:team])
    @team.group = @group
    respond_to do |format|
      if @team.save
        format.html { redirect_to [@group, @team] }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @team = @group.teams.find(params[:id])
  end

  def update
    @team = @group.teams.find(params[:id])
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to [@group, @team] }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @team = @group.teams.find(params[:id])
    @team.destroy
    redirect_to @group
  end

  private

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end
end
