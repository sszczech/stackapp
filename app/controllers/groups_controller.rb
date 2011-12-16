class GroupsController < UserApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @post = @group.posts.build
  end
end
