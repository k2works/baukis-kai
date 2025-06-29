class FormPresenter
  include HtmlBuilder

  attr_reader :form_builder,
              :view_context

  delegate :label,
           :text_field,
           :password_field,
           :check_box,
           :radio_button,
           :text_area,
           :object, to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def notes
    markup(:div, class: 'AppForm__notes') do |m|
      m.span '*', class: 'AppForm__notes--mark'
      m.text '印の付いた項目は入力必須です。'
    end
  end

  def text_field_block(name, label_text, options = {})
    markup(:div, class: 'AppForm__input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, hide_label: true, class: options[:required] ? 'required' : nil)
      if options[:maxlength]
        m.span "(#{options[:maxlength]}文字以内)", class: 'instruction'
      end
      m << error_message_for(name)
    end
  end

  def number_field_block(name, label_text, options = {})
    markup(:div) do |m|
      m << decorated_label(name, label_text, options)
      m << form_builder.number_field(name, options.merge(skip_label: true))
      if options[:max]
        max = view_context.number_with_delimiter(options[:max].to_i)
        m.span "(最大値： #{max})", class: 'instruction'
      end
      m << error_message_for(name)
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: 'AppForm__input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << password_field(name, hide_label: true, class: options[:required] ? 'required' : nil)
      m << error_message_for(name)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: 'AppForm__input-block') do |m|
      m << decorated_label(name, label_text, options)
      if options[:class].kind_of?(String)
        classes = options[:class].strip.split + ['datetimepicker']
        options[:class] = classes.uniq.join(' ')
      else
        options[:class] = 'datetimepicker'
      end
      m << text_field(name, options.merge(hide_label: true))
      m << error_message_for(name)
    end
  end

  def drop_down_list_block(name, label_text, choices, options ={})
    markup(:div, class: 'AppForm__input-block') do |m|
      m << form_builder.select(name, choices, options.merge(include_blank: true).merge(label: label_text))
      m << error_message_for(name)
    end
  end

  def error_message_for(name)
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: 'has-error') do |m|
          m.span(message, class: 'help-block')
        end
      end
    end
  end

  def decorated_label(name, label_text, options = {})
    label(name, label_text, class: options[:required] ? 'AppForm__label required' : 'AppForm__label')
  end

end
