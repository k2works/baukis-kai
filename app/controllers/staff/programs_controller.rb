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

  def create
    @program_form = Staff::ProgramForm.new
    @program_form.assign_attributes(params[:form])
    @program_form.program.registrant = current_staff_member
    if @program_form.save
      flash.notice = t('.flash_notice')
      redirect_to action: 'index'
    else
      flash.now.alert = t('.flash_alert')
      render action: 'new'
    end
  end

  def update
    @program_form = Staff::ProgramForm.new(Program.find(params[:id]))
    @program_form.assign_attributes(params[:form])
    if @program_form.save
      flash.notice = t('.flash_notice')
      redirect_to action: 'index'
    else
      flash.now.alert = t('.flash_alert')
      render action: 'edit'
    end
  end

  def destroy
    program = Program.find(params[:id])
    program.destroy!
    flash.notice = t('.flash_notice')
    redirect_to :staff_programs
  end

  # PATCH
  def entries
    entries_form = Staff::EntriesForm.new(Program.find(params[:id]))
    entries_form.assign_attributes(params[:form])
    entries_form.save
    flash.notice = t('.flash_notice')
    redirect_to :staff_programs
  end
end
