# == Schema Information
#
# Table name: staff_members # 職員
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null               # メールアドレス
#  email_for_index  :string(255)      not null               # 索引用メールアドレス
#  family_name      :string(255)      not null               # 姓
#  given_name       :string(255)      not null               # 名
#  family_name_kana :string(255)      not null               # 姓（カナ）
#  given_name_kana  :string(255)      not null               # 名（カナ）
#  hashed_password  :string(255)                             # パスワード
#  start_date       :date             not null               # 開始日
#  end_date         :date                                    # 終了日
#  suspended        :boolean          default("0"), not null # 停止フラグ
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_staff_members_on_email_for_index                       (email_for_index) UNIQUE
#  index_staff_members_on_family_name_kana_and_given_name_kana  (family_name_kana,given_name_kana)
#

class StaffMember < ApplicationRecord
  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  before_validation do
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today)
  end
end
