require 'rails_helper'

# 職員による顧客管理
feature 'Customer management by staff' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  # 職員が顧客、自宅住所、勤務先を更新する
  scenario 'Staff update customer, home address, work place' do
    click_link I18n.t('staff.top.dashboard.staff_customers')

    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'test@example.jp'
    within('fieldset#home-address-fields') do
      fill_in I18n.t('activerecord.attributes.home_address.postal_code'), with: '99999999'
    end
    within('fieldset#work-address-fields') do
      fill_in I18n.t('activerecord.attributes.work_address.company_name'), with: 'テスト'
    end
    click_button I18n.t('staff.customers.edit.update')

    customer.reload
    expect(customer.email).to eq('test@example.jp')
    expect(customer.home_address.postal_code).to eq('99999999')
    expect(customer.work_address.company_name).to eq('テスト')
  end
end