class Admin::StaffMemberPresenter < ModelPresenter
  delegate :suspended?, to: :object

  def suspended_mark
    suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end
end