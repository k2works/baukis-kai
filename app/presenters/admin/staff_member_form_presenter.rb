class Admin::StaffMemberFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    if object.new_record?
      super(name, label_text,options)
    end
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:dvi,class: 'AppForm__input-block') do |m|
      m << label(name1, label_text ,class: options[:required] ? 'AppForm__label required' : 'AppForm__label')
      m << text_field(name1, hide_label: true, class: options[:required] ? 'required' : nil)
      m << text_field(name2, hide_label: true, class: options[:required] ? 'required' : nil)
    end
  end

  def check_boxes
    markup(:div, class: 'AppForm__input-block') do |m|
      m << label(:suspended, I18n.t('activerecord.attributes.staff_member.suspended_on'))
      m << check_box(:suspended)
    end
  end
end