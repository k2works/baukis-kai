class Admin::SessionsController < Admin::Base
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(post_params)
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = t('common.session.create.alert_account')
        render action: 'new'
      else
        session[:administrator_id] = administrator.id
        session[:last_access_time] = Time.current
        flash.notice = t('common.session.create.notice')
        redirect_to :admin_root
      end
    else
      flash.now.alert = t('common.session.create.alert_mail_password')
      render action: 'new'
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = t('common.session.destroy.notice')
    redirect_to :admin_root
  end

  private
  def post_params
    params.require(:admin_login_form).permit(
        :email,
        :password
    )
  end
  
end
