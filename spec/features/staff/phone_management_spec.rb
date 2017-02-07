require 'rails_helper'

# 職員による顧客電話番号管理
feature 'Customer telephone number management by staff' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  # 職員が顧客の電話番号を追加する
  scenario "The staff adds the customer's phone number" do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    fill_in 'form_customer_phones_0_number', with: '090-9999-9999'
    check 'form_customer_phones_0_primary'
    click_button I18n.t('staff.customers.edit.update')

    customer.reload
    expect(customer.personal_phones.size).to eq(1)
    expect(customer.personal_phones[0].number).to eq('090-9999-9999')
  end

  # 職員が顧客の自宅電話番号を追加する
  scenario "The staff adds the customer's home phone number" do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    fill_in 'form_home_address_phones_0_number', with: '090-9999-9999'
    check 'form_home_address_phones_0_primary'
    click_button I18n.t('staff.customers.edit.update')

    customer.reload
    expect(customer.home_address.phones.size).to eq(1)
    expect(customer.home_address.phones[0].number).to eq('090-9999-9999')
  end

  # 職員が顧客の勤務先電話番号を追加する
  scenario "The staff adds the customer's work phone number" do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    fill_in 'form_work_address_phones_0_number', with: '03-9999-9999'
    check 'form_work_address_phones_0_primary'
    click_button I18n.t('staff.customers.edit.update')

    customer.reload
    expect(customer.work_address.phones.size).to eq(1)
    expect(customer.work_address.phones[0].number).to eq('03-9999-9999')
  end
end