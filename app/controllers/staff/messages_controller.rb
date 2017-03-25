class Staff::MessagesController < Staff::Base
  before_action :reject_non_xhr, only: [ :count ]

  def index
    @messages = Message.where(deleted: false).page(params[:page])
    if params[:tag_id]
      @messages = @messages.joins(:message_tag_links).where('message_tag_links.tag_id' => params[:tag_id])
    end
    @messages = @messages.page(params[:page])
  end

  # GET
  def inbound
    @messages = CustomerMessage.where(deleted: false).page(params[:page])
    render action: 'index'
  end

  # GET
  def outbound
    @messages = StaffMessage.where(deleted: false).page(params[:page])
    render action: 'index'
  end

  # GET
  def deleted
    @messages = Message.where(deleted: true).page(params[:page])
    render action: 'index'
  end

  # GET
  def count
    render text: CustomerMessage.unprocessed.count
  end

  def show
    @message = Message.find(params[:id])
  end

  def destroy
    message = CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = t('.flash_notice')
    redirect_to :back
  end

  # POST/DELETE
  def tag
    message = CustomerMessage.find(params[:id])
    if request.post?
      message.add_tag(params[:label])
    elsif request.delete?
      message.remove_tag(params[:label])
    else
      raise
    end
    render text: 'OK'
  end
end
