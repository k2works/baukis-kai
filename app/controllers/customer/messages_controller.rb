class Customer::MessagesController < Customer::Base
  def index
    @messages = current_customer.inbound_messages.page(params[:page])
  end

  def new
    @message = CustomerMessage.new
  end

  # POST
  def confirm
    @message = CustomerMessage.new(customer_message_params)
    if @message.valid?
      render action: 'confirm'
    else
      flash.now.alert = t('.flash_alert')
      render action: 'new'
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = t('.flash_notice')
        redirect_to :customer_root
      else
        flash.now.alert = t('.flash_alert')
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  private
  def customer_message_params
    params.require(:customer_message).permit(
        :subject,
        :body
    )
  end
end
