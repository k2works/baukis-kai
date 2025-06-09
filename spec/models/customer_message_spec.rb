require 'rails_helper'

RSpec.describe CustomerMessage, type: :model do
  describe 'validations' do
    it 'can be created without staff_member, root, or parent' do
      customer = FactoryBot.create(:customer)
      message = CustomerMessage.new(
        customer: customer,
        subject: 'Test Subject',
        body: 'Test Body'
      )
      
      expect(message).to be_valid
      expect { message.save! }.not_to raise_error
    end
  end
end