class Customer::MessagesController < Customer::Base
  def new
    @message = CustomerMessage.new
  end
end
