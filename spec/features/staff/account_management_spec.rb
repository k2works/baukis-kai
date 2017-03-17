require 'rails_helper'

feature '職員による自分自身のアカウント管理' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
    click_link I18n.t('staff.shared.header.account')
    click_link I18n.t('staff.accounts.show.edit')
  end

  scenario '職員がメールアドレス、氏名、フリガナを更新する' do
    fill_in I18n.t('activerecord.attributes.staff_member.email'), with: 'test@oiax.jp'
    fill_in 'staff_member_family_name', with: '試験'
    fill_in 'staff_member_given_name', with: '花子'
    fill_in 'staff_member_family_name_kana', with: 'シケン'
    fill_in 'staff_member_given_name_kana', with: 'ハナコ'
    click_button I18n.t('staff.accounts.edit.confirm')
    click_button I18n.t('staff.accounts.confirm.update')

    staff_member.reload
    expect(staff_member.email).to eq('test@oiax.jp')
    expect(staff_member.family_name).to eq('試験')
    expect(staff_member.given_name_kana).to eq('ハナコ')
  end

  scenario '職員がメールアドレスに無効な値を入力する' do
    fill_in I18n.t('activerecord.attributes.staff_member.email'), with: 'test@@oiax.jp'
    click_button I18n.t('staff.accounts.edit.confirm')
    expect(page).to have_css('.has-error span.help-block')
  end
end