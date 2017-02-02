class Staff::PasswordsController < Staff::Base
  def show
    redirect_to :edit_staff_password
  end

  def edit
    @change_password_form = Staff::ChangePasswordForm.new(object: current_staff_member)
  end

  def update
    @change_password_form = Staff::ChangePasswordForm.new(staff_member_params)
    @change_password_form.object = current_staff_member
    if @change_password_form
      flash.notice = t('.flash_success')
      redirect_to :staff_account
    else
      flash.new.alert = t('.flash_alert')
      render action: 'edit'
    end
  end

  private
  def staff_member_params
    params.require(:staff_change_password_form).permit(
                                                   :current_password,
                                                   :new_password,
                                                   :new_password_confirmation
    )
  end
end
