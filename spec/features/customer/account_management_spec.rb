require 'rails_helper'

feature '顧客によるアカウント管理' do
  include FeaturesSpecHelper
  let(:customer) { create(:customer) }

  before do
    switch_namespace(:customer)
    login_as_customer(customer)
    click_link I18n.t('customer.shared.header.account')
    click_link I18n.t('customer.accounts.show.edit')
  end

  scenario '顧客が基本情報、自宅住所、勤務先を更新する' do
    fill_in I18n.t('activerecord.attributes.customer.birthday'), with: '1980-04-01'
    within('fieldset#home-address-fields') do
      fill_in I18n.t('activerecord.attributes.home_address.postal_code'), with: '9999999'
    end
    click_button I18n.t('customer.accounts.edit.confirm')
    click_button I18n.t('customer.accounts.confirm.correct')
    within('fieldset#work-address-fields') do
      fill_in I18n.t('activerecord.attributes.work_address.company_name'), with: 'テスト'
    end
    click_button I18n.t('customer.accounts.edit.confirm')
    click_button I18n.t('customer.accounts.edit.update')

    customer.reload
    expect(customer.birthday).to eq(Date.new(1980,4,1))
    expect(customer.home_address.postal_code).to eq('9999999')
    expect(customer.work_address.company_name).to eq('テスト')
  end

  scenario '顧客が生年月日と自宅の郵便番号に無効な値を入力する' do
    fill_in I18n.t('activerecord.attributes.customer.birthday'), with: '2100-01-01'
    within('fieldset#home-address-fields') do
      fill_in I18n.t('activerecord.attributes.home_address.postal_code'), with: 'XYZ'
    end
    click_button I18n.t('customer.accounts.edit.confirm')

    expect(page).to have_css('header span.Flash__alert')
    expect(page).to have_css('.has-error span.help-block')
  end
end