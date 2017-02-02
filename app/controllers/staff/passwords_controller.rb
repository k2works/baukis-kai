class Staff::PasswordsController < Staff::Base
  def show
    redirect_to :edit_staff_password
  end
end
