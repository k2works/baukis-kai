class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  private
  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end
end
