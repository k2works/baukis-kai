class Admin::AllowedSourcesController < Admin::Base
  def index
    @allowed_sources = AllowedSource.order(:octet1, :octet2, :octet3, :octet4)
    @new_allowed_source = AllowedSource.new
  end

  def create
    @new_allowed_source = AllowedSource.new(allowed_source_params)
    @new_allowed_source.namespace = 'staff'
    if @new_allowed_source.save
      flash.notice = t('.flash_notice')
      redirect_to action: 'index'
    else
      @allowed_sources = AllowedSource.order(:octet1, :octet2, :octet3, :octet4)
      flash.now.alert = t('.flash_alert')
      render action: 'index'
    end
  end

  private
  def allowed_source_params
    params.require(:allowed_source).permit(:octet1,
                                           :octet2,
                                           :octet3,
                                           :last_octet)
  end
end
