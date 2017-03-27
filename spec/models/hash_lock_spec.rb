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

require 'rails_helper'

RSpec.describe HashLock, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
