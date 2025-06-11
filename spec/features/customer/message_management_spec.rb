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
    visit new_customer_message_path

    fill_in I18n.t('activerecord.attributes.message.subject'), with: 'テストメッセージ'
    fill_in I18n.t('activerecord.attributes.message.body'), with: 'これはテストメッセージです。'
    click_button I18n.t('customer.messages.new.submit')
    click_button I18n.t('customer.messages.confirm.update')
    
    expect(page).to have_css('.Flash__notice', text: I18n.t('customer.messages.create.flash_notice'))
    expect(Message.find_by(subject: 'テストメッセージ', customer: customer)).to be_present
  end

  scenario '顧客がメッセージ履歴を確認する' do
    # Create a message from customer to staff
    message = create(:customer_message, customer: customer)
    # Create a reply from staff to customer
    create(:staff_message, parent: message, staff_member: staff_member)
    
    visit customer_messages_path
    click_link I18n.t('customer.messages.index.detail')

    expect(page).to have_content(message.subject)
    expect(page).to have_content(message.body.to_s.delete("\n"))
  end

  scenario '顧客がスタッフからのメッセージに回答する' do
    # Create a message from customer to staff
    message = create(:customer_message, customer: customer)
    # Create a reply from staff to customer
    create(:staff_message, parent: message, staff_member: staff_member)

    visit customer_messages_path
    click_link I18n.t('customer.messages.index.detail')
    click_link I18n.t('customer.messages.show.reply')
    fill_in I18n.t('activerecord.attributes.message.subject'), with: '回答テストメッセージ'
    fill_in I18n.t('activerecord.attributes.message.body'), with: 'これは回答テストメッセージです。'
    click_button I18n.t('customer.replies.new.submit')
    click_button I18n.t('customer.replies.confirm.send')

    expect(page).to have_css('.Flash__notice', text: I18n.t('customer.replies.create.flash_notice'))
    expect(Message.find_by(subject: '回答テストメッセージ', customer: customer)).to be_present
  end

  scenario '顧客がスタッフからのメッセージを削除する' do
    # Create a message from customer to staff
    message = create(:customer_message, customer: customer)
    # Create a reply from staff to customer
    create(:staff_message, parent: message, staff_member: staff_member)

    visit customer_messages_path
    click_link I18n.t('customer.messages.index.delete')

    expect(page).to have_css('.Flash__notice', text: I18n.t('customer.messages.destroy.flash_notice'))
  end

end