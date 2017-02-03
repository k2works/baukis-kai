class UserFormPresenter < FormPresenter
  def password_field_block(name, label_text, options = {})
    if object.new_record?
      super(name, label_text,options)
    else
      markup(:div, class: 'AppForm__input-block') do |m|
        m << decorated_label(name, label_text, options.merge(required: false))
        m << password_field(name, options.merge(disabled: true).merge(hide_label: true))
        m.button('変更する',type: 'button', id: 'enable-password-field', class: 'btn btn-warning btn-xs')
        m.button('変更しない', type: 'button', id: 'disable-password-field',style: 'display: none', class: 'btn btn-primary btn-xs')
      end
    end
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:dvi,class: 'AppForm__input-block') do |m|
      m << decorated_label(name1, label_text, options)
      m << text_field(name1, hide_label: true, class: options[:required] ? 'required' : nil)
      m << text_field(name2, hide_label: true, class: options[:required] ? 'required' : nil)
    end
  end
end