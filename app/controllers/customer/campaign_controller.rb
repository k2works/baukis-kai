class Customer::CampaignController < ApplicationController
  def index
  end

  def submit
    redirect_to :customer_root
  end
end