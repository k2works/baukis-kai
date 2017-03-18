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

require 'rails_helper'

RSpec.describe Tag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
