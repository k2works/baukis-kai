class Staff::EntriesForm
  include ActiveModel::Model

  attr_accessor :program,
                :approved,
                :not_approved,
                :canceled,
                :not_canceled

  def initialize(program)
    @program = program
  end
end