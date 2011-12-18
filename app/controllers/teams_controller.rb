class TeamsController < ApplicationController

  before_filter :group

  def new
    @team = Team.new
  end

  def show
    @team = @group.teams.find(params[:id])
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

  def destroy
    @team = @group.teams.find(params[:id])
    @team.destroy
    redirect_to @group
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end
end
