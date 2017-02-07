class AlterPhones2 < ActiveRecord::Migration[5.0]
  def change
    add_column :phones, :last_four_digits, :string, comment: '電話番号下４桁'

    add_index :phones, :last_four_digits
  end
end
