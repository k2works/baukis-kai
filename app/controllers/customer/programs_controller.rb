class Customer::ProgramsController < Customer::Base
  def index
    @programs = Program.published.page(params[:page])
  end

  def show
    @program = Program.published.find_by(params[:id])
  end
end
