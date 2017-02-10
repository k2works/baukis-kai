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

  def delete
    if Admin::AllowedSourcesDeleter.new.delete(allowed_sources_params(params[:form]))
      flash.notice = t('.flash_notice')
    end
    redirect_to action: 'index'
  end

  private
  def allowed_source_params
    params.require(:allowed_source).permit(:octet1,
                                           :octet2,
                                           :octet3,
                                           :last_octet)
  end

  def allowed_sources_params(form)
    arr = Array.new
    form[:allowed_sources].each do |v|
      h = Hash.new
      h.store(:id,form[:allowed_sources][v].permit([:id,:_destroy]).to_h[:id])
      h.store(:_destroy,form[:allowed_sources][v].permit([:id,:_destroy]).to_h[:_destroy])
      arr << h
    end
    arr
  end
end
