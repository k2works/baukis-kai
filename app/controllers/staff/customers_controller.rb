class Staff::CustomersController < Staff::Base
  def index
    @search_form = Staff::CustomerSearchForm.new(params[:search])
    @customers = @search_form.search.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer_form = Staff::CustomerForm.new
  end

  def edit
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
  end

  def create
    @customer_form = Staff::CustomerForm.new
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = t('.flash_notice')
      redirect_to action: 'index'
    else
      flash.now.alert = t('.flash_alert')
      render action: 'new'
    end
  end

  def update
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = t('.flash_notice')
      redirect_to action: 'index'
    else
      flash.now.alert = t('.flash_alert')
      render action: 'edit'
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = t('.flash_notice')
    redirect_to :staff_customers
  end
end
