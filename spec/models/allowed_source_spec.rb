# == Schema Information
#
# Table name: allowed_sources # IPアドレス制限
#
#  id         :integer          not null, primary key
#  namespace  :string(255)      not null               # 名前空間
#  octet1     :integer          not null               # 第１オクテット
#  octet2     :integer          not null               # 第２オクテット
#  octet3     :integer          not null               # 第３オクテット
#  octet4     :integer          not null               # 第４オクテット
#  wildcard   :boolean          default("0"), not null # ワイルドカード
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_allowed_sources_on_namespace_and_octets  (namespace,octet1,octet2,octet3,octet4) UNIQUE
#

require 'rails_helper'

RSpec.describe AllowedSource, type: :model do
  describe '#ip_address=' do
    # 引数に"127.0.0.1"を与えた場合
    example 'When "127.0.0.1" is given as an argument' do
      src = AllowedSource.new(namespace: 'staff', ip_address: '127.0.0.1')
      expect(src.octet1).to eq(127)
      expect(src.octet2).to eq(0)
      expect(src.octet3).to eq(0)
      expect(src.octet4).to eq(1)
      expect(src).not_to be_wildcard
      expect(src).to be_valid
    end

    # 引数に"192.168.0.*"を与えた場合
    example 'When "192.168.0.*" is given as an argument' do
      src = AllowedSource.new(namespace: 'staff', ip_address: '192.168.0.*')
      expect(src.octet1).to eq(192)
      expect(src.octet2).to eq(168)
      expect(src.octet3).to eq(0)
      expect(src.octet4).to eq(0)
      expect(src).to be_wildcard
      expect(src).to be_valid
    end

    # 引数に不正な文字列を与えた場合
    example 'When an invalid character string is given as an argument' do
      src = AllowedSource.new(namespace: 'staff', ip_address: 'A.B.C.D')
      expect(src).not_to be_valid
    end
  end
end
