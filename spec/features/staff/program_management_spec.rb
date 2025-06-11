require 'rails_helper'

feature '職員によるプログラム管理' do
  include FeaturesSpecHelper
  include PerformanceSpecHelper
  let(:staff_member) { create(:staff_member) }
  let!(:program) { create(:program, registrant: staff_member) }
  let(:customer) { create(:customer) }
  let!(:entry) { create(:entry, program: program, customer: customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario '職員がプログラム一覧を表示する' do
    visit staff_programs_path
    expect(page).to have_css('h1', text: I18n.t('staff.programs.index.title'))
    expect(page).to have_content(program.title)
  end

  scenario '職員がプログラム詳細を表示する' do
    visit staff_program_path(program)

    expect(page).to have_content(program.title)
    expect(page).to have_content(program.description)
  end

  scenario '職員が新規プログラムを登録する' do
    visit staff_programs_path
    first('a', text: I18n.t('staff.programs.index.new')).click

    fill_in I18n.t('activerecord.attributes.program.title'), with: 'New Program'
    fill_in I18n.t('activerecord.attributes.program.description'), with: 'Program Description'
    fill_in I18n.t('activerecord.attributes.program.application_start_date'), with: Date.today.to_s
    select '09', from: "form_program_application_start_hour"
    select '00', from: "form_program_application_start_minute"
    fill_in I18n.t('activerecord.attributes.program.application_end_date'), with: Date.today.next_month.to_s
    select '17', from: "form_program_application_end_hour"
    select '00', from: "form_program_application_end_minute"
    fill_in I18n.t('activerecord.attributes.program.min_number_of_participants'), with: '5'
    fill_in I18n.t('activerecord.attributes.program.max_number_of_participants'), with: '10'

    click_button I18n.t('staff.programs.new.create')

    expect(page).to have_css('.Flash__notice', text: I18n.t('staff.programs.create.flash_notice'))
    expect(Program.find_by(title: 'New Program')).to be_present
  end

  scenario '職員がプログラムを編集する' do
    visit edit_staff_program_path(program)

    fill_in I18n.t('activerecord.attributes.program.title'), with: 'Updated Program'
    click_button I18n.t('staff.programs.edit.update')

    expect(page).to have_css('.Flash__notice', text: I18n.t('staff.programs.update.flash_notice'))
    expect(program.reload.title).to eq('Updated Program')
  end

  scenario '職員がプログラムを削除する' do
    program_without_entries = create(:program, registrant: staff_member)

    visit staff_programs_path

    all('a', text: I18n.t('staff.programs.form.delete')).last.click

    # JavaScriptアラートを受け入れる
    # page.driver.browser.switch_to.alert.accept

    expect(page).to have_css('.Flash__notice', text: I18n.t('staff.programs.destroy.flash_notice'))
    expect(Program.find_by(id: program_without_entries.id)).to be_nil
  end

  # type: :system指定時の挙動が不安定なので JavaScriptを使うE2Eテストは除外
  xscenario '職員がエントリーを管理する' do
    visit staff_program_path(program)

    find("input[type='checkbox'].isApproved[data-entry-id='#{entry.id}']").click
    click_button I18n.t('staff.programs.entries_form.update')

    expect(page).to have_css('.Flash__notice', text: I18n.t('staff.programs.entries.flash_notice'))
    expect(entry.reload.approved).to be true
  end
end
