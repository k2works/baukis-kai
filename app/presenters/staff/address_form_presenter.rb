class Staff::AddressFormPresenter < FormPresenter
  def postal_code_block(name, label_text, options)
    markup(:div, class: 'AppForm__input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, hide_label: true, class: options[:required] ? 'required' : nil)
      m.span '(7桁の半角数字で入力してください。)', class: 'AppForm__notes'
    end
  end
end