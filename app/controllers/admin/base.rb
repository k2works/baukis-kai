class Admin::Base < ApplicationController
  before_action :authorize

  private
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
          Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator

  private
  def authorize
    unless current_administrator
      flash.alert = t('admin.base.authrize.flash_alert')
      redirect_to :admin_login
    end
  end
end