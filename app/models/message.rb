# == Schema Information
#
# Table name: messages # 問い合わせ
#
#  id              :integer          not null, primary key
#  customer_id     :integer          not null
#  staff_member_id :integer
#  root_id         :integer                                   # Messageへの外部キー
#  parent_id       :integer                                   # Messageへの外部キー
#  type            :string(255)      not null                 # 継承カラム
#  status          :string(255)      default("new"), not null # 状態（職員向け）
#  subject         :string(255)      not null                 # 件名
#  body            :text(65535)                               # 本文
#  remarks         :text(65535)                               # 備考（職員向け）
#  discarded       :boolean          default("0"), not null   # 顧客側の削除フラグ
#  deleted         :boolean          default("0"), not null   # 職員側の削除フラグ
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  fk_rails_aafcb31dbf                                         (parent_id)
#  index_messages_on_c_d_s_c                                   (customer_id,deleted,status,created_at)
#  index_messages_on_customer_id                               (customer_id)
#  index_messages_on_customer_id_and_deleted_and_created_at    (customer_id,deleted,created_at)
#  index_messages_on_customer_id_and_discarded_and_created_at  (customer_id,discarded,created_at)
#  index_messages_on_root_id_and_deleted_and_created_at        (root_id,deleted,created_at)
#  index_messages_on_staff_member_id                           (staff_member_id)
#  index_messages_on_type_and_customer_id                      (type,customer_id)
#  index_messages_on_type_and_staff_member_id                  (type,staff_member_id)
#

class Message < ApplicationRecord
  belongs_to :customer
  belongs_to :staff_member
  belongs_to :root, class_name: 'Message', foreign_key: 'root_id'
  belongs_to :parent, class_name: 'Message', foreign_key: 'parent_id'
  has_many :message_tag_links, dependent: :destroy
  has_many :tags, -> { order(:value)}, through: :message_tag_links

  validates :subject, :body, presence: true
  validates :subject, length: { maximum: 80, allow_blank: true }
  validates :body, length: { maximum: 800, allow_blank: true }

  before_create do
    if parent
      self.customer = parent.customer
      self.root = parent.root || parent
    end
  end

  default_scope { order(created_at: :desc) }

  before_validation do
    if parent
      self.root = parent.root || parent
      self.customer = parent.customer
    end
  end

  attr_accessor :child_nodes

  def tree
    return @tree if @tree
    r = root || self
    messages = Message.where(root_id: r.id).select(:id, :parent_id, :subject)
    @tree = SimpleTree.new(r,messages)
  end

  def add_tag(label)
    self.class.transaction do
      tag = Tag.find_by_created_at(value: label)
      tag ||= Tag.create!(value: label)
      unless message_tag_links.where(tag_id: tag.id).exists?
        message_tag_links.create!(tag_id: tag.id)
      end
    end
  end

  def remove_tag(label)
    self.class.transaction do
      if tag = Tag.find_by(value: label)
        message_tag_links.find_by(tag_id: tag.id).destroy
        if tag.message_tag_links.empty?
          tag.destroy
        end
      end
    end
  end
end
