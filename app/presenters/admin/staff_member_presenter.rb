class Admin::StaffMemberPresenter < ModelPresenter
  # 職員の停止フラグのOn/Offを表現する記号を返す。
  #   On: BALLOT BOX WITH CHECk (U+2611)
  #   Off: BALLOT BOX WITH CHECK (U+2610)
  def suspended_mark
    object.suspended? ? view_context.raw('&#x2611;') : view_context.raw('&#x2610;')
  end
end