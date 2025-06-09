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
    click_link program.title
    
    expect(page).to have_css('h1', text: program.title)
    expect(page).to have_content(program.description)
  end

  scenario '顧客がプログラムを予約する' do
    visit customer_program_path(program)
    click_link I18n.t('customer.programs.show.apply')
    
    fill_in I18n.t('activerecord.attributes.entry.remarks'), with: 'テスト予約'
    click_button I18n.t('customer.entries.new.submit')
    
    expect(page).to have_css('.notice', text: I18n.t('customer.entries.create.notice'))
    expect(Entry.find_by(program: program, customer: customer)).to be_present
  end

  scenario '顧客が予約をキャンセルする' do
    entry = create(:entry, program: program, customer: customer)
    
    visit customer_entries_path
    click_link program.title
    click_link I18n.t('customer.entries.show.cancel')
    
    expect(page).to have_css('.notice', text: I18n.t('customer.entries.cancel.notice'))
    expect(entry.reload.canceled).to be_truthy
  end

  scenario '顧客が予約期間外のプログラムを予約しようとする' do
    closed_program = create(:program, application_start_time: 10.days.from_now, application_end_time: 20.days.from_now)
    
    visit customer_program_path(closed_program)
    
    expect(page).not_to have_link(I18n.t('customer.programs.show.apply'))
    expect(page).to have_content(I18n.t('customer.programs.show.not_applicable'))
  end

  scenario '顧客が定員超過のプログラムを予約しようとする' do
    full_program = create(:program, application_start_time: 2.days.ago, application_end_time: 2.days.from_now, max_number_of_participants: 1)
    create(:entry, program: full_program) # Fill the program
    
    visit customer_program_path(full_program)
    
    expect(page).not_to have_link(I18n.t('customer.programs.show.apply'))
    expect(page).to have_content(I18n.t('customer.programs.show.full'))
  end
end