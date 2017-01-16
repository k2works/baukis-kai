class Staff::CampaignController < ApplicationController
  def index
  end

  def submit
    redirect_to :staff_root
  end
end