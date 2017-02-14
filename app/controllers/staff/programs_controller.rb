class Staff::ProgramsController < Staff::Base
  def index
    @programs = Program.listing.page(params[:page])
  end

  def show
    @program = Program.find(params[:id])
  end
end
