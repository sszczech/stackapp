class AttachmentsController < UserApplicationController
  def show
    @attachment = Attachment.find(params[:id])
    send_file @attachment.file.current_path
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    redirect_to :back
  end
end
