class Admin::StaffMemberFormPresenter < UserFormPresenter
  def check_boxes
    markup(:div, class: 'AppForm__input-block') do |m|
      m << label(:suspended, I18n.t('activerecord.attributes.staff_member.suspended_on'))
      m << check_box(:suspended)
    end
  end
end