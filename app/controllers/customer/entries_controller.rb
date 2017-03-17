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

  # PATCH
  def cancel
    program = Program.published.find(params[:program_id])
    entry = program.entries.where(customer_id: current_customer.id).first!
    entry.update_column(:canceled, true)
    flash.notice = t('.flash_notice')
    redirect_to [:customer, program ]
  end
end
