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
    
    visit admin_staff_member_path(staff_member)
    click_link I18n.t('admin.staff_members.show.events')
    
    expect(page).to have_css('h1', text: I18n.t('admin.staff_events.index.title'))
    expect(page).to have_selector('table.staff-events tbody tr', count: 2)
  end

  scenario '管理者がIPアドレス制限を設定する' do
    visit admin_allowed_sources_path
    click_link I18n.t('admin.allowed_sources.index.new')
    
    fill_in I18n.t('activerecord.attributes.allowed_source.octet1'), with: '192'
    fill_in I18n.t('activerecord.attributes.allowed_source.octet2'), with: '168'
    fill_in I18n.t('activerecord.attributes.allowed_source.octet3'), with: '1'
    fill_in I18n.t('activerecord.attributes.allowed_source.octet4'), with: '0'
    fill_in I18n.t('activerecord.attributes.allowed_source.wildcard'), with: true
    fill_in I18n.t('activerecord.attributes.allowed_source.note'), with: 'テスト用'
    click_button I18n.t('admin.allowed_sources.new.submit')
    
    expect(page).to have_css('.notice', text: I18n.t('admin.allowed_sources.create.notice'))
    expect(AllowedSource.find_by(octet1: 192, octet2: 168, octet3: 1, octet4: 0, wildcard: true)).to be_present
  end

  scenario '管理者がタグを管理する' do
    visit admin_tags_path
    click_link I18n.t('admin.tags.index.new')
    
    fill_in I18n.t('activerecord.attributes.tag.value'), with: 'テストタグ'
    click_button I18n.t('admin.tags.new.submit')
    
    expect(page).to have_css('.notice', text: I18n.t('admin.tags.create.notice'))
    expect(Tag.find_by(value: 'テストタグ')).to be_present
    
    # Edit tag
    click_link 'テストタグ'
    click_link I18n.t('admin.tags.show.edit')
    fill_in I18n.t('activerecord.attributes.tag.value'), with: '更新タグ'
    click_button I18n.t('admin.tags.edit.submit')
    
    expect(page).to have_css('.notice', text: I18n.t('admin.tags.update.notice'))
    expect(Tag.find_by(value: '更新タグ')).to be_present
    
    # Delete tag
    click_link I18n.t('admin.tags.show.delete')
    expect(page).to have_css('.notice', text: I18n.t('admin.tags.destroy.notice'))
    expect(Tag.find_by(value: '更新タグ')).to be_nil
  end
end