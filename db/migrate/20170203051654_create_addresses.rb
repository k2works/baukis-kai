class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses,comment:'住所' do |t|
      t.references :customer, null: false, comment:'顧客への外部キー'
      t.string :type, null: false, comment:'継承カラム'
      t.string :postal_code, null: false, comment:'郵便番号'
      t.string :prefecture, null: false, comment:'都道府県'
      t.string :city, null: false, comment:'市区町村'
      t.string :address1, null: false, comment:'町域・番地等'
      t.string :address2, null: false, comment:'建物名・部屋番号'
      t.string :company_name, null: false, default: '', comment:'会社名'
      t.string :division_name, null: false, default: '', comment:'部署名'

      t.timestamps
    end

    add_index :addresses, [:type, :customer_id], unique: true
    add_foreign_key :addresses, :customers
  end
end
