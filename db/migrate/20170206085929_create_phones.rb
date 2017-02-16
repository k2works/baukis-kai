class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones,comment:'電話' do |t|
      t.references :customer, null: false, comment: '顧客への外部キー'
      t.references :address, comment: '住所への外部キー'
      t.string :number, null: false, comment: '電話番号'
      t.string :number_for_index, null: false, comment: '索引用電話番号'
      t.boolean :primary,   null: false, default: false, comment: '優先フラグ'

      t.timestamps
    end

    add_index :phones, :number_for_index
    add_foreign_key :phones, :customers
    add_foreign_key :phones, :addresses
  end
end
