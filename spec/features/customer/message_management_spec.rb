require 'rails_helper'

feature '顧客によるメッセージ管理' do
  include FeaturesSpecHelper
  let(:customer) { create(:customer) }
  let(:staff_member) { create(:staff_member) }

  before do
    switch_namespace(:customer)
    login_as_customer(customer)
  end

  scenario '顧客がスタッフにメッセージを送信する' do
    visit customer_messages_path
    click_link I18n.t('customer.messages.index.new')
    
    fill_in I18n.t('activerecord.attributes.message.subject'), with: 'テストメッセージ'
    fill_in I18n.t('activerecord.attributes.message.body'), with: 'これはテストメッセージです。'
    select staff_member.family_name + staff_member.given_name, from: I18n.t('activerecord.attributes.message.staff_member_id')
    click_button I18n.t('customer.messages.new.submit')
    
    expect(page).to have_css('.notice', text: I18n.t('customer.messages.create.notice'))
    expect(Message.find_by(subject: 'テストメッセージ', customer: customer)).to be_present
  end

  scenario '顧客がメッセージ履歴を確認する' do
    # Create a message from customer to staff
    message = create(:message, customer: customer, staff_member: staff_member)
    # Create a reply from staff to customer
    create(:reply, message: message, staff_member: staff_member)
    
    visit customer_messages_path
    click_link message.subject
    
    expect(page).to have_css('h1', text: message.subject)
    expect(page).to have_content(message.body)
    expect(page).to have_css('.replies .reply', count: 1)
  end

  scenario '顧客がメッセージを検索する' do
    create(:message, customer: customer, staff_member: staff_member, subject: '問い合わせ')
    create(:message, customer: customer, staff_member: staff_member, subject: '予約について')
    
    visit customer_messages_path
    fill_in I18n.t('customer.messages.index.search_form.subject'), with: '予約'
    click_button I18n.t('customer.messages.index.search_form.submit')
    
    expect(page).to have_content('予約について')
    expect(page).not_to have_content('問い合わせ')
  end

  scenario '顧客がメッセージにタグを付ける' do
    tag = create(:tag, value: 'テストタグ')
    
    visit customer_messages_path
    click_link I18n.t('customer.messages.index.new')
    
    fill_in I18n.t('activerecord.attributes.message.subject'), with: 'タグ付きメッセージ'
    fill_in I18n.t('activerecord.attributes.message.body'), with: 'これはタグ付きメッセージです。'
    select staff_member.family_name + staff_member.given_name, from: I18n.t('activerecord.attributes.message.staff_member_id')
    check "tag_#{tag.id}"
    click_button I18n.t('customer.messages.new.submit')
    
    expect(page).to have_css('.notice', text: I18n.t('customer.messages.create.notice'))
    message = Message.find_by(subject: 'タグ付きメッセージ', customer: customer)
    expect(message).to be_present
    expect(message.tags).to include(tag)
  end
end