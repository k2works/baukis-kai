class Staff::ProgramForm
  include ActiveModel::Model

  attr_accessor :program
  delegate :persisted?,
           :save, to: :program

  def initialize(progaram = nil)
    @program = progaram
    @program ||= Program.new
    if @program.application_start_time
      @program.application_start_date = @program.application_start_time.to_date.to_s
      @program.application_start_hour = sprintf('%02d', @program.application_start_time.hour)
      @program.application_start_minute = sprintf('%02d', @program.application_start_time.min)
    else
      @program.application_start_hour = '09'
      @program.application_start_minute = '00'
    end
    if @program.application_end_time
      @program.application_end_date = @program.application_end_time.to_date.to_s
      @program.application_end_hour = sprintf('%02d', @program.application_end_time.hour)
      @program.application_end_minute = sprintf('%02d', @program.application_end_time.min)
    else
      @program.application_end_hour = '17'
      @program.application_end_minute = '00'
    end
  end
end