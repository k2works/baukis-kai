class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages,comment: '問い合わせ' do |t|
      t.references :customer, null: false
      t.references :staff_member
      t.integer :root_id, comment: 'Messageへの外部キー'
      t.integer :parent_id, comment: 'Messageへの外部キー'
      t.string :type, null: false, comment: '継承カラム'
      t.string :status, null: false, default: 'new', comment: '状態（職員向け）'
      t.string :subject, null: false, comment: '件名'
      t.text :body, comment: '本文'
      t.text :remarks, comment: '備考（職員向け）'
      t.boolean :discarded, null: false, default: false, comment: '顧客側の削除フラグ'
      t.boolean :deleted, null: false, default: false, comment: '職員側の削除フラグ'

      t.timestamps
    end
    add_index :messages, [ :type, :customer_id ]
    add_index :messages, [ :customer_id, :discarded, :created_at ]
    add_index :messages, [ :type, :staff_member_id ]
    add_index :messages, [ :customer_id, :deleted, :created_at ]
    add_index :messages, [ :customer_id, :deleted, :status, :created_at ], name: 'index_messages_on_c_d_s_c'
    add_index :messages, [ :root_id, :deleted, :created_at ]

    add_foreign_key :messages, :customers
    add_foreign_key :messages, :staff_members
    add_foreign_key :messages, :messages, column: :root_id
    add_foreign_key :messages, :messages, column: :parent_id
  end
end
