# encoding: utf-8
class ContainersController < UserApplicationController

  before_filter :group
  before_filter :container, :only => [:show, :edit, :update, :destroy]

  def new
    @container = @group.containers.build
  end

  def create
    @container = @group.containers.build(params[:container])
    @container.group = @group
    @container.owner = current_user
    respond_to do |format|
      if @container.save
        format.html { redirect_to [@group, @container] }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def show
  end

  def edit
    unless @group.teacher == current_user
      forbidden
      return
    end
  end

  def update
    unless @group.teacher == current_user
      forbidden
      return
    end
    respond_to do |format|
      if @container.update_attributes(params[:container])
        format.html { redirect_to [@group, @container] }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def upload
    @container = @group.containers.find(params[:container_id])
    unless @container.has_access?(current_user)
      forbidden
      return
    end
    @attachment = @container.attachments.build(params[:attachment])
    @attachment.author = current_user
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to [@group, @container], :notice => "Plik został zapisany na serwerze." }
      else
        format.html { redirect_to [@group, @container], :alert => "Błąd podczas zapisywania pliku." }
      end
    end
  end

  def destroy
    unless @group.teacher == current_user
      forbidden
      return
    end
    @container.destroy
    redirect_to @group
  end

  private

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end

  def container
    @container ||= @group.containers.find(params[:id])
  end
end
