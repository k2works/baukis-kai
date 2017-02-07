class AlterAddresses2 < ActiveRecord::Migration[5.0]
  def change
    add_index :addresses, :postal_code
  end
end
