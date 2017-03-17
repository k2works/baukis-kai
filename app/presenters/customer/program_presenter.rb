class Customer::ProgramPresenter < ModelPresenter
  delegate :title, :description, to: :object
  delegate :number_with_delimiter, to: :view_context

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
end