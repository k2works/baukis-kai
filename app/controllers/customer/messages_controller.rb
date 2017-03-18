class Customer::MessagesController < Customer::Base
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

  private
  def customer_message_params
    params.require(:customer_message).permit(
        :subject,
        :body
    )
  end
end
