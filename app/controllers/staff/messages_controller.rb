class Staff::MessagesController < Staff::Base
  # GET
  def count
    render text: CustomerMessage.unprocessed.count
  end
end
