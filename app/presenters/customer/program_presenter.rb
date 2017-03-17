class Customer::ProgramPresenter < ModelPresenter
  delegate :title,
           :description, to: :object
  delegate :number_with_delimiter,
           :button_to, to: :view_context

  def initialize(object, view_context)
    super
    @delegated_presenter = Staff::ProgramPresenter.new(@object, @view_context)
  end

  def application_start_time
    @delegated_presenter.application_start_time
  end

  def application_end_time
    @delegated_presenter.application_end_time
  end

  def max_number_of_participants
    @delegated_presenter.max_number_of_participants
  end

  def min_number_of_participants
    @delegated_presenter.min_number_of_participants
  end

  def apply_or_cancel_button
    closed = object.application_end_time < Time.current
    label_text = closed ? I18n.t('customer.programs.show.closed') : I18n.t('customer.programs.show.apply')
    button_to label_text, [ :customer, object, :entries ], disabled: closed, method: :post, class: 'btn btn-default', data: { confirm: I18n.t('customer.programs.show.confirm')}
  end
end