#!/usr/bin/env ruby
require_relative 'config/environment'

# Create a customer
customer = Customer.first || Customer.create!(
  email: 'test@example.com',
  family_name: 'Test',
  given_name: 'User',
  family_name_kana: 'テスト',
  given_name_kana: 'ユーザー',
  password: 'password',
  birthday: Date.new(1980, 1, 1),
  gender: 'male'
)

# Create a CustomerMessage without staff_member, root, or parent
message = CustomerMessage.new(
  customer: customer,
  subject: 'Test Subject',
  body: 'Test Body'
)

puts "Message valid? #{message.valid?}"
if message.valid?
  message.save!
  puts "Message saved successfully with ID: #{message.id}"
else
  puts "Message validation errors: #{message.errors.full_messages.join(', ')}"
end