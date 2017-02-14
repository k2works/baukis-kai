class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs, comment: 'プログラム' do |t|
      t.integer :registrant_id, null: false, comment: '登録職員（外部キー）'
      t.string :title, null: false, comment: 'タイトル'
      t.text :description, comment: '説明'
      t.datetime :application_start_time, null: false, comment: '申し込み開始日'
      t.datetime :application_end_time, null: false, comment: '申し込み終了日'
      t.integer :min_number_of_participants, comment: '最小参観者数'
      t.integer :max_number_of_participants, comment: '最大参観者数'

      t.timestamps
    end

    add_index :programs, :registrant_id
    add_index :programs, :application_start_time
    add_foreign_key :programs, :staff_members, column: 'registrant_id'
  end
end
