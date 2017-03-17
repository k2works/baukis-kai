class Customer::AccountsController < Customer::Base
  def show
    @customer = current_customer
  end
end
