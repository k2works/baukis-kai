class Staff::MessagesController < Staff::Base
  before_action :reject_non_xhr, only: [ :count ]

  def index
    @messages = Message.where(deleted: false).page(params[:page])
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
end
