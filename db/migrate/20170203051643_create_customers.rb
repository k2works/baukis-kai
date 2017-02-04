class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers,comment:'顧客' do |t|
      t.string :email, null: false, comment:'メールアドレス'
      t.string :email_for_index, null: false, comment:'顧客用メールアドレス'
      t.string :family_name, null: false, comment:'姓'
      t.string :given_name, null: false, comment:'名'
      t.string :family_name_kana, null: false, comment:'姓（カナ）'
      t.string :given_name_kana, null: false, comment:'名（カナ）'
      t.string :gender, comment:'性別'
      t.date :birthday, comment:'誕生日'
      t.string :hashed_password, comment:'パスワード'

      t.timestamps
    end

    add_index :customers, :email_for_index, unique: true
    add_index :customers, [:family_name_kana, :given_name_kana]
  end
end
