require 'rails_helper'

feature '管理者によるスタッフ管理' do
  include FeaturesSpecHelper
  let(:administrator) { create(:administrator) }

  before do
    switch_namespace(:admin)
    login_as_administrator(administrator)
  end

  scenario '管理者が新規スタッフアカウントを作成する' do
    click_link I18n.t('admin.top.dashboard.admin_staff_members')
    first('a', text: I18n.t('admin.staff_members.index.new')).click
    
    fill_in I18n.t('activerecord.attributes.staff_member.email'), with: 'test@example.com'
    fill_in I18n.t('activerecord.attributes.staff_member.family_name'), with: '試験'
    fill_in I18n.t('activerecord.attributes.staff_member.given_name'), with: '太郎'
    fill_in I18n.t('activerecord.attributes.staff_member.family_name_kana'), with: 'シケン'
    fill_in I18n.t('activerecord.attributes.staff_member.given_name_kana'), with: 'タロウ'
    fill_in I18n.t('activerecord.attributes.staff_member.hashed_password'), with: 'password'
    fill_in I18n.t('activerecord.attributes.staff_member.start_date'), with: Date.today.strftime('%Y-%m-%d')
    click_button I18n.t('admin.staff_members.new.create')

    expect(page).to have_css('.Flash__notice', text: '職員アカウントを新規登録しました。')
    expect(StaffMember.find_by(email: 'test@example.com')).to be_present
  end

  scenario '管理者がスタッフアカウントを編集する' do
    staff_member = create(:staff_member)
    visit admin_staff_members_path

    first('a', text: I18n.t('admin.staff_members.index.edit')).click
    fill_in I18n.t('activerecord.attributes.staff_member.email'), with: 'edited@example.com'
    click_button I18n.t('admin.staff_members.edit.update')

    expect(page).to have_css('.Flash__notice', text: '職員アカウントを更新しました。')
    expect(staff_member.reload.email).to eq('edited@example.com')
  end

  scenario '管理者がスタッフアカウントを停止する' do
    staff_member = create(:staff_member)
    visit admin_staff_members_path

    first('a', text: I18n.t('admin.staff_members.index.edit')).click
    check I18n.t('activerecord.attributes.staff_member.suspended')
    click_button I18n.t('admin.staff_members.edit.update')

    expect(page).to have_css('.Flash__notice', text: '職員アカウントを更新しました。')
    expect(staff_member.reload.suspended).to be_truthy
  end

  scenario '管理者がスタッフアカウントを再開する' do
    staff_member = create(:staff_member, suspended: true)
    visit admin_staff_members_path

    first('a', text: I18n.t('admin.staff_members.index.edit')).click
    uncheck I18n.t('activerecord.attributes.staff_member.suspended')
    click_button I18n.t('admin.staff_members.edit.update')

    expect(page).to have_css('.Flash__notice', text: '職員アカウントを更新しました。')
    expect(staff_member.reload.suspended).to be_falsey
  end
end