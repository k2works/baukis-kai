class Customer::CampaignController < Customer::Base
  def index
  end

  def submit
    redirect_to :customer_root
  end
end