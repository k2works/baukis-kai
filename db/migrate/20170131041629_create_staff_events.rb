class CreateStaffEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :staff_events,comment:'職員イベント' do |t|
      t.references :staff_member, null: false , comment:'職員レコードへの外部キー'
      t.string :type, null: false, comment:'イベントタイプ'
      t.datetime :created_at, null: false, comment:'発生時刻'
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [:staff_member_id, :created_at]
    add_foreign_key :staff_events, :staff_members
  end
end
