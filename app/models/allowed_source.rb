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

class AllowedSource < ApplicationRecord
  validates :octet1, :octet2, :octet3, :octet4,
            presence: true,
            numericality: { only_integer: true, allow_blank: true },
            inclusion: { in: 0..255, allow_blank: true }
  validates :octet4,
            uniqueness: { scope: [ :octet1, :octet2, :octet3 ], allow_blank: true }

  def ip_address=(ip_address)
    octets = ip_address.split('.')
    self.octet1 = octets[0]
    self.octet2 = octets[1]
    self.octet3 = octets[2]
    if octets[3] == '*'
      self.octet4 = 0
      self.wildcard = true
    else
      self.octet4 = octets[3]
    end
  end
end
