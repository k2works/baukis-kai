require 'rails_helper'

feature '管理者によるアカウント管理' do
  include FeaturesSpecHelper
  let(:administrator) { create(:administrator) }

  before do
    switch_namespace(:admin)
  end

  scenario '管理者がログインする' do
    visit admin_login_path
    within('.Login--admin') do
      fill_in I18n.t('activemodel.attributes.admin/login_form.email'), with: administrator.email
      fill_in I18n.t('activemodel.attributes.admin/login_form.password'), with: 'pw'
      click_button I18n.t('admin.sessions.new.submit')
    end

    expect(current_path).to eq(admin_root_path)
    expect(page).to have_content(administrator.email)
  end

  scenario '管理者がログアウトする' do
    login_as_administrator(administrator)
    click_link I18n.t('admin.shared.header.logout')
    
    expect(current_path).to eq(admin_login_path)
    expect(page).to have_css('.notice', text: I18n.t('admin.sessions.destroy.notice'))
  end

  scenario '管理者が無効なパスワードでログインを試みる' do
    visit admin_login_path
    within('.Login--admin') do
      fill_in I18n.t('activemodel.attributes.admin/login_form.email'), with: administrator.email
      fill_in I18n.t('activemodel.attributes.admin/login_form.password'), with: 'wrong_password'
      click_button I18n.t('admin.sessions.new.submit')
    end

    expect(current_path).to eq(admin_login_path)
    expect(page).to have_css('.alert', text: I18n.t('admin.sessions.create.alert'))
  end
end