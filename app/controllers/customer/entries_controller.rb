class Customer::EntriesController < Customer::Base
  def create
    program = Program.published.find(params[:program_id])
    case Customer::EntryAcceptor.new(current_customer).accept(program)
      when :accepted
        flash.notice = t('.flash_notice')
      when :full
        flash.alert = t('.flash_alert')
      when :closed
        flash.alert =  t('.flash_alert_close')
      end
    redirect_to [ :customer, program ]
  end
end
