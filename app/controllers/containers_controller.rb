class ContainersController < UserApplicationController

  before_filter :group

  def new
    @container = @group.containers.build(params[:container])
  end

  def create
    
  end

  def destroy
    @container = @group.containers.find(params[:id])
    @container.destroy
    redirect_to @group
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end
end
