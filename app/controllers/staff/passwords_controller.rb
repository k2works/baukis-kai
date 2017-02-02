class Staff::PasswordsController < Staff::Base
  def show
    redirect_to :edit_staff_password
  end

  def edit
    @change_password_form = Staff::ChangePasswordForm.new(object: current_staff_member)
  end
end
