class Customer::AccountsController < Customer::Base
  def show
    @customer = current_customer
  end

  def edit
    @customer_form = Customer::AccountForm.new(current_customer)
  end

  def update
    @customer_form = Customer::AccountForm.new(current_customer)
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = t('.flash_notice')
      redirect_to :staff_account
    else
      flash.now.alert = t('.flash_alert')
      render action: 'edit'
    end
  end
end
