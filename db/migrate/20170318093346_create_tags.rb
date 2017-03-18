class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags,comment:'タグ' do |t|
      t.string :value, null: false, commet:'タグ値'
      t.timestamps
    end

    add_index :tags, :value, unique:true
  end
end
