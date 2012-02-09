# encoding: utf-8
class GroupsController < UserApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @post = @group.posts.build

    respond_to do |format|
      unless @group.users.include?(current_user)
        format.html { forbidden }
      else
        format.html
      end
    end
  end
end
