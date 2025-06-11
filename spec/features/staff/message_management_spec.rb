require 'rails_helper'

feature '職員によるメッセージ管理' do
  include FeaturesSpecHelper
  include PerformanceSpecHelper
  let(:staff_member) { create(:staff_member) }
  let(:customer) { create(:customer) }
  let!(:root_message) { create(:customer_message, subject: 'Hello', customer: customer) }
  let!(:reply1) { create(:staff_message, parent: root_message, staff_member: staff_member) }
  let!(:message1) { create(:customer_message, parent: reply1, customer: customer) }
  let!(:message2) { create(:customer_message, parent: reply1, customer: customer) }
  let!(:reply2) { create(:staff_message, parent: message1, staff_member: staff_member) }
  let!(:reply3) { create(:staff_message, parent: message1, staff_member: staff_member) }
  let!(:message3) { create(:customer_message, parent: reply3, customer: customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario '職員がメッセージ一覧を表示する' do
    visit staff_messages_path
    expect(page).to have_css('h1', text: I18n.t('staff.messages.index.title_index'))
    expect(page).to have_content('Hello')
  end

  scenario '職員が問い合わせ一覧を表示する' do
    visit inbound_staff_messages_path
    expect(page).to have_css('h1', text: I18n.t('staff.messages.index.title_inbound'))
    expect(page).to have_content('Hello')
  end

  scenario '職員が返信一覧を表示する' do
    visit outbound_staff_messages_path
    expect(page).to have_css('h1', text: I18n.t('staff.messages.index.title_outbound'))
  end

  scenario '職員が顧客からのメッセージに返信する' do
    visit staff_message_path(root_message)
    within('.Table__links') do
      click_link I18n.t('staff.messages.show.reply')
    end

    fill_in I18n.t('activerecord.attributes.message.subject'), with: 'Re: Hello'
    fill_in I18n.t('activerecord.attributes.message.body'), with: 'This is a reply to your message.'
    click_button I18n.t('staff.replies.new.confirm')
    click_button I18n.t('staff.replies.confirm.send')

    expect(page).to have_css('.Flash__notice', text: I18n.t('staff.replies.create.flash_notice'))
    expect(StaffMessage.find_by(subject: 'Re: Hello', staff_member: staff_member)).to be_present
  end

  scenario '職員が問い合わせを削除する' do
    visit staff_message_path(root_message)
    expect(page).to have_css('h1', text: 'メッセージ詳細')

    visit staff_messages_path

    within("tr", text: root_message.subject) do
      click_link I18n.t('staff.messages.index.delete')
    end

    expect(page).to have_css('.Flash__notice', text: I18n.t('staff.messages.destroy.flash_notice'))
    expect(Message.find(root_message.id).deleted).to be true
  end
end
