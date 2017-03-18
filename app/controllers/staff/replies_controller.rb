class Staff::RepliesController < Staff::Base
  before_action :prepare_message

  def new
    @reply = StaffMessage.new
  end

  private
  def prepare_message
    @message = CustomerMessage.find(params[:message_id])
  end
end
