class Staff::ProgramsController < Staff::Base
  def index
    @programs = Program.listing.page(params[:page])
  end

  def show
    @program = Program.listing.find(params[:id])
  end

  def new
    @program_form = Staff::ProgramForm.new
  end

  def edit
    @program_form = Staff::ProgramForm.new(Program.find(params[:id]))
  end
end
