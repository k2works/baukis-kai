class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  rescue_from Exception, with: :rescue500

  private
  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

  def rescue500(e)
    @exception = e
    render 'errors/internal_server_error', status: 500
  end
end
