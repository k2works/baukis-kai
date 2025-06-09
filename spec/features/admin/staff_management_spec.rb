require 'rails_helper'

feature '管理者によるスタッフ管理' do
  include FeaturesSpecHelper
  let(:administrator) { create(:administrator) }

  before do
    switch_namespace(:admin)
    login_as_administrator(administrator)
  end

  scenario '管理者が新規スタッフアカウントを作成する' do
    click_link I18n.t('admin.staff_members.index.new')
    
    fill_in I18n.t('activerecord.attributes.staff_member.email'), with: 'test@example.com'
    fill_in I18n.t('activerecord.attributes.staff_member.family_name'), with: '試験'
    fill_in I18n.t('activerecord.attributes.staff_member.given_name'), with: '太郎'
    fill_in I18n.t('activerecord.attributes.staff_member.family_name_kana'), with: 'シケン'
    fill_in I18n.t('activerecord.attributes.staff_member.given_name_kana'), with: 'タロウ'
    fill_in I18n.t('activerecord.attributes.staff_member.password'), with: 'password'
    click_button I18n.t('admin.staff_members.new.submit')

    expect(page).to have_css('.notice', text: I18n.t('admin.staff_members.create.notice'))
    expect(StaffMember.find_by(email: 'test@example.com')).to be_present
  end

  scenario '管理者がスタッフアカウントを編集する' do
    staff_member = create(:staff_member)
    visit admin_staff_members_path
    click_link staff_member.family_name + staff_member.given_name

    click_link I18n.t('admin.staff_members.show.edit')
    fill_in I18n.t('activerecord.attributes.staff_member.email'), with: 'edited@example.com'
    click_button I18n.t('admin.staff_members.edit.submit')

    expect(page).to have_css('.notice', text: I18n.t('admin.staff_members.update.notice'))
    expect(staff_member.reload.email).to eq('edited@example.com')
  end

  scenario '管理者がスタッフアカウントを停止する' do
    staff_member = create(:staff_member)
    visit admin_staff_members_path
    
    within("#staff_member_#{staff_member.id}") do
      click_link I18n.t('admin.staff_members.index.suspend')
    end

    expect(page).to have_css('.notice', text: I18n.t('admin.staff_members.suspend.notice'))
    expect(staff_member.reload.suspended).to be_truthy
  end

  scenario '管理者がスタッフアカウントを再開する' do
    staff_member = create(:staff_member, suspended: true)
    visit admin_staff_members_path
    
    within("#staff_member_#{staff_member.id}") do
      click_link I18n.t('admin.staff_members.index.resume')
    end

    expect(page).to have_css('.notice', text: I18n.t('admin.staff_members.resume.notice'))
    expect(staff_member.reload.suspended).to be_falsey
  end
end