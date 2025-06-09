require 'rails_helper'

feature '管理者によるシステム管理' do
  include FeaturesSpecHelper
  let(:administrator) { create(:administrator) }

  before do
    switch_namespace(:admin)
    login_as_administrator(administrator)
  end

  scenario '管理者がスタッフイベントログを確認する' do
    staff_member = create(:staff_member)
    # Create some staff events
    staff_member.events.create!(type: 'logged_in')
    staff_member.events.create!(type: 'logged_out')
    
    visit admin_staff_events_path

    expect(page).to have_css('h1', text: I18n.t('admin.staff_events.index.title'))
    expect(page).to have_selector('table.Table__body tr.Table__tr', count: 3)
  end

  scenario '管理者がIPアドレス制限を設定する' do
    visit admin_allowed_sources_path

    fill_in 'allowed_source_octet1', with: '192'
    fill_in 'allowed_source_octet2', with: '168'
    fill_in 'allowed_source_octet3', with: '1'
    fill_in 'allowed_source_last_octet', with: '*'
    click_button '追加'

    expect(page).to have_css('.Flash__notice', text: I18n.t('admin.allowed_sources.create.flash_notice'))
    expect(AllowedSource.find_by(octet1: 192, octet2: 168, octet3: 1, octet4: 0, wildcard: true)).to be_present
  end
end