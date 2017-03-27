class CreateHashLocks < ActiveRecord::Migration[5.0]
  def change
    create_table :hash_locks, comment:'排他制御' do |t|
      t.string :table, null: false, comment: 'テーブル'
      t.string :column, null: false, comment: 'カラム'
      t.string :key, null: false, comment: 'キー'
      t.timestamps
    end

    add_index :hash_locks, [ :table, :column, :key ], unique: true
  end
end
