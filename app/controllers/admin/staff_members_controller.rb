class Admin::StaffMembersController < Admin::Base

  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [ :edit, :admin, staff_member ]
  end

  def new
    @staff_member = StaffMember.new
  end

  def edit
    @staff_member = StaffMember.find(params[:id])
  end

  def create
    @staff_member = StaffMember.new(staff_member_params)
    if @staff_member.save
      flash.notice = t('.flash_success')
      redirect_to :admin_staff_members
    else
      render action: 'new'
    end
  end

  def update
    @staff_member = StaffMember.find(params[:id])
    @staff_member.assign_attributes(staff_member_params)
    if @staff_member.save
      flash.notice = t('.flash_success')
      redirect_to :admin_staff_members
    else
      render action: 'edit'
    end
  end

  def destroy
    staff_member = StaffMember.find(params[:id])
    if staff_member.deletable?
      staff_member.destroy!
      flash.notice = t('.flash_success')
    else
      flash.alert = t('.flash_alert')
    end
    redirect_to :admin_staff_members
  end

  private
  def staff_member_params
    params.require(:staff_member).permit(
                                     :email,
                                     :password,
                                     :family_name,
                                     :given_name,
                                     :family_name_kana,
                                     :given_name_kana,
                                     :start_date,
                                     :end_date,
                                     :suspended
    )
  end

end
