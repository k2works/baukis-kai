class Customer::EntriesController < Customer::Base
  def create
    program = Program.published.find(params[:program_id])
    case Customer::EntryAcceptor.new(current_customer).accept(program)
      when :accepted
        flash.notice = t('.flash_notice')
      when :full
        flash.alert = t('.flash_alert')
      end
    redirect_to [ :customer, program ]
  end
end
