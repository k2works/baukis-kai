# == Schema Information
#
# Table name: tags # タグ
#
#  id         :integer          not null, primary key
#  value      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_value  (value) UNIQUE
#

class Tag < ApplicationRecord
end
