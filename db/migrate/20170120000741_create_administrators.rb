class CreateAdministrators < ActiveRecord::Migration[5.0]
  def change
    create_table :administrators, comment: '管理者' do |t|
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :email_for_index, null: false, comment: '索引用メールアドレス'
      t.string :hashed_password, comment: 'パスワード'
      t.boolean :suspended, null: false, default: false, comment: '停止フラグ'


      t.timestamps
    end

    add_index :administrators, :email_for_index, unique: true
  end
end
