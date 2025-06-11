require 'rails_helper'

feature '顧客によるプログラム管理' do
  include FeaturesSpecHelper
  let(:customer) { create(:customer) }
  let!(:program) { create(:program, application_start_time: 2.days.ago, application_end_time: 2.days.from_now) }

  before do
    switch_namespace(:customer)
    login_as_customer(customer)
  end

  scenario '顧客がプログラム一覧を閲覧する' do
    visit customer_programs_path
    
    expect(page).to have_css('h1', text: I18n.t('customer.programs.index.title'))
    expect(page).to have_content(program.title)
  end

  scenario '顧客がプログラム詳細を閲覧する' do
    visit customer_programs_path
    click_link I18n.t('staff.programs.form.show')

    expect(page).to have_content(program.title)
    expect(page).to have_content(program.description)
  end

  scenario '顧客がプログラムを予約する' do
    visit customer_program_path(program)
    click_button I18n.t('customer.programs.show.apply')
    
    expect(page).to have_css('.Flash__notice', text: I18n.t('customer.entries.create.flash_notice'))
    expect(Entry.find_by(program: program, customer: customer)).to be_present
  end

  scenario '顧客が予約をキャンセルする' do
    visit customer_program_path(program)
    click_button I18n.t('customer.programs.show.apply')
    visit customer_program_path(program)
    click_button I18n.t('customer.programs.show.cancel')

    expect(page).to have_css('.Flash__notice', text: I18n.t('customer.entries.cancel.flash_notice'))
    expect(Entry.find_by(program: program, customer: customer).canceled).to be true
  end

  scenario '顧客が予約期間外のプログラムを予約しようとする' do
    Program.delete_all
    closed_program = create(:program, application_start_time: 20.days.ago, application_end_time: 10.days.ago)
    visit customer_programs_path

    visit customer_program_path(closed_program)
    
    expect(page).to have_button(I18n.t('customer.programs.show.closed'), disabled: true)
  end
end