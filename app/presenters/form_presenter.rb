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
      m << label(name, label_text,class: options[:required] ? 'AppForm__label required' : 'AppForm__label')
      m << text_field(name, hide_label: true, class: options[:required] ? 'required' : nil)
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: 'AppForm__input-block') do |m|
      m << label(name, label_text, class: options[:required] ? 'AppForm__label required' : 'AppForm__label')
      m << password_field(name, hide_label: true, class: options[:required] ? 'required' : nil)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: 'AppForm__input-block') do |m|
      m << label(name, label_text,class: options[:required] ? 'AppForm__label required' : 'AppForm__label')
      m << text_field(name, hide_label: true, class: options[:required] ? 'required' : nil)
    end
  end
end