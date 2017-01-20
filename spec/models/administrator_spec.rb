# == Schema Information
#
# Table name: administrators # 管理者
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null               # メールアドレス
#  email_for_index :string(255)      not null               # 索引用メールアドレス
#  hashed_password :string(255)                             # パスワード
#  suspended       :boolean          default("0"), not null # 停止フラグ
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_administrators_on_email_for_index  (email_for_index) UNIQUE
#

require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe '#password=' do
    # 文字列を与えると、hashed_passwordは長さ60の文字列になる
    it 'is a string of length 60 of hashed_password when giving a string' do
      admin = Administrator.new
      admin.password = 'baukis'
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    # nilを与えると、hashed_passwordはnilになる
    it 'is nil of hashed_password when giving a nil' do
      admin = Administrator.new(hashed_password: 'x')
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
  end
end
