require 'rails_helper'

feature '職員による顧客管理' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario '職員が顧客（基本情報のみ）を登録する' do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('.Table__links').click_link I18n.t('staff.customers.index.new')
    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'test@example.jp'
    fill_in I18n.t('activerecord.attributes.customer.hashed_password'), with: 'pw'
    fill_in 'form_customer_family_name', with: '試験'
    fill_in 'form_customer_given_name', with: '花子'
    fill_in 'form_customer_family_name_kana', with: 'シケン'
    fill_in 'form_customer_given_name_kana', with: 'ハナコ'
    fill_in I18n.t('activerecord.attributes.customer.birthday'), with: '1970-01-01'
    choose '女性'
    click_button I18n.t('staff.customers.new.create')

    new_customer = Customer.order(:id).last
    expect(new_customer.email).to eq('test@example.jp')
    expect(new_customer.birthday).to eq(Date.new(1970,1,1))
    expect(new_customer.gender).to eq('female')
    expect(new_customer.home_address).to be_nil
    expect(new_customer.work_address).to be_nil
  end

  scenario '職員が顧客、自宅住所、勤務先を更新する' do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'test@example.jp'
    within('fieldset#home-address-fields') do
      fill_in I18n.t('activerecord.attributes.home_address.postal_code'), with: '9999999'
    end
    within('fieldset#work-address-fields') do
      fill_in I18n.t('activerecord.attributes.work_address.company_name'), with: 'テスト'
    end
    click_button I18n.t('staff.customers.edit.update')

    customer.reload
    expect(customer.email).to eq('test@example.jp')
    expect(customer.home_address.postal_code).to eq('9999999')
    expect(customer.work_address.company_name).to eq('テスト')
  end

  scenario '職員が顧客、自宅住所、勤務先を登録する' do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('.Table__links').click_link I18n.t('staff.customers.index.new')

    fill_in I18n.t('activerecord.attributes.customer.email'), with: 'test@example.jp'
    fill_in I18n.t('activerecord.attributes.customer.hashed_password'), with: 'pw'
    fill_in 'form_customer_family_name', with: '試験'
    fill_in 'form_customer_given_name', with: '花子'
    fill_in 'form_customer_family_name_kana', with: 'シケン'
    fill_in 'form_customer_given_name_kana', with: 'ハナコ'
    fill_in I18n.t('activerecord.attributes.customer.birthday'), with: '1970-01-01'
    choose '女性'
    check I18n.t('staff.customers.new.home_address_inputs')
    within('fieldset#home-address-fields') do
      fill_in I18n.t('activerecord.attributes.home_address.postal_code'), with: '1000001'
      select '東京都', from: I18n.t('activerecord.attributes.home_address.prefecture')
      fill_in I18n.t('activerecord.attributes.home_address.city'), with: '千代田区'
      fill_in I18n.t('activerecord.attributes.home_address.address1'), with: '千代田1-1-1'
      fill_in I18n.t('activerecord.attributes.home_address.address2'), with: ''
    end
    check I18n.t('staff.customers.new.work_address_inputs')
    within('fieldset#work-address-fields') do
      fill_in I18n.t('activerecord.attributes.work_address.company_name'), with: 'テスト'
      fill_in I18n.t('activerecord.attributes.work_address.division_name'), with: ''
      fill_in I18n.t('activerecord.attributes.work_address.postal_code'), with: ''
      select '', from: I18n.t('activerecord.attributes.work_address.prefecture')
      fill_in I18n.t('activerecord.attributes.work_address.city'), with: ''
      fill_in I18n.t('activerecord.attributes.work_address.address1'), with: ''
      fill_in I18n.t('activerecord.attributes.work_address.address2'), with: ''
    end
    click_button I18n.t('staff.customers.new.create')

    new_customer = Customer.order(:id).last
    expect(new_customer.email).to eq('test@example.jp')
    expect(new_customer.birthday).to eq(Date.new(1970,1,1))
    expect(new_customer.gender).to eq('female')
    expect(new_customer.home_address.postal_code).to eq('1000001')
    expect(new_customer.work_address.company_name).to eq('テスト')
  end

  scenario '職員が生年月日と自宅の郵便番号に無効な値を入力する' do
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    fill_in I18n.t('activerecord.attributes.customer.birthday'), with: '2100-01-01'
    within('fieldset#home-address-fields') do
      fill_in I18n.t('activerecord.attributes.home_address.postal_code'), with: 'XYZ'
    end
    click_button I18n.t('staff.customers.edit.update')

    expect(page).to have_css('header span.Flash__alert')
    expect(page).to have_css('.has-error span.help-block')
  end

  scenario '職員が勤務先データのない既存顧客に会社名の情報を追加する' do
    customer.work_address.destroy
    click_link I18n.t('staff.top.dashboard.staff_customers')
    first('table.Table__body--listing').click_link I18n.t('staff.customers.index.edit')

    check I18n.t('staff.customers.new.work_address_inputs')
    within('fieldset#work-address-fields') do
      fill_in I18n.t('activerecord.attributes.work_address.company_name'), with: 'テスト'
    end
    click_button I18n.t('staff.customers.edit.update')

    customer.reload
    expect(customer.work_address.company_name).to eq('テスト')
  end
end
