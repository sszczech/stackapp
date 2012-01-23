# encoding: utf-8
class ContainersController < UserApplicationController

  before_filter :group

  def new
    @container = @group.containers.build
  end

  def create
    @container = @group.containers.build(params[:container])
    @container.group = @group
    respond_to do |format|
      if @container.save
        format.html { redirect_to [@group, @container] }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def show
    @container = @group.containers.find(params[:id])
  end

  def edit
    @container = @group.containers.find(params[:id])
  end

  def update
    @container = @group.containers.find(params[:id])
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
    @container = @group.containers.find(params[:id])
    @container.destroy
    redirect_to @group
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end
end
