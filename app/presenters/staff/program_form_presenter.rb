class Staff::ProgramFormPresenter < FormPresenter
  def description
    markup(:div, class: 'AppForm__input-block') do |m|
      m << decorated_label(:description, I18n.t('staff.programs.form.show'), required: true)
      m << text_area(:description, hide_label: true, row: 6, style: 'width: 454px')
      m.span '(800文字以内)', class: 'instruction', style: 'float: right'
      m << error_message_for(:description)
    end
  end

  def datetime_field_block(name, label_text, options = {})
    instruction = options.delete(:instruction)
    if object.errors.include?("#{name}_time".to_sym)
      html_class = 'AppForm__input-block AppForm--with-errors'
    else
      html_class = 'AppForm__input-block'
    end
    markup(:div, class: 'AppForm__input-block html_class') do |m|
      m << decorated_label("#{name}_date", label_text, options)
      if options[:class].kind_of?(String)
        classes = options[:class].strip.split + [ 'datetimepicker' ]
        options[:class] = classes.uniq.join(' ')
      else
        options[:class] = 'datetimepicker'
      end
      m << text_field("#{name}_date", options.merge(hide_label: true))
      m << form_builder.select("#{name}_hour", ('00'..'23').to_a, skip_label: true)
      m << ':'
      m << form_builder.select("#{name}_minute", ('00'..'59').to_a, skip_label: true)
      m.span "(#{instruction})", class: 'instruction' if instruction
      m << error_message_for("#{name}_time".to_sym)
      m << error_message_for("#{name}_date".to_sym)
    end
  end
end