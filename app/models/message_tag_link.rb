# == Schema Information
#
# Table name: message_tag_links # タグリンクテーブル
#
#  id         :integer          not null, primary key
#  message_id :integer          not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_message_tag_links_on_message_id             (message_id)
#  index_message_tag_links_on_message_id_and_tag_id  (message_id,tag_id) UNIQUE
#  index_message_tag_links_on_tag_id                 (tag_id)
#

class MessageTagLink < ApplicationRecord
  belongs_to :message
  belongs_to :tag
end
