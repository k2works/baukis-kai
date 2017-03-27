# == Schema Information
#
# Table name: hash_locks # 排他制御
#
#  id         :integer          not null, primary key
#  table      :string(255)      not null              # テーブル
#  column     :string(255)      not null              # カラム
#  key        :string(255)      not null              # キー
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hash_locks_on_table_and_column_and_key  (table,column,key) UNIQUE
#

class HashLock < ApplicationRecord
  class << self
    def acquire(table, column, value)
      HashLock.where(table: table,
                     column: column,
                     key: Digest::MD5.hexdigest(value)[0,2]
      ).lock(true).first!
    end
  end
end
