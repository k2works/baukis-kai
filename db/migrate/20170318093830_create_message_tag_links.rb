class CreateMessageTagLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :message_tag_links,comment:'タグリンクテーブル' do |t|
      t.references :message, null: false
      t.references :tag, null: false
    end

    add_index :message_tag_links, [ :message_id, :tag_id ], unique: true
  end
end
