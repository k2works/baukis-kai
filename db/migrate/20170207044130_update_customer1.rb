class UpdateCustomer1 < ActiveRecord::Migration[5.0]
  def up
    if Rails.env != 'test'
      execute(%q{
      UPDATE customers SET birth_year = EXTRACT(YEAR FROM birthday),
       birth_month = EXTRACT(MONTH FROM birthday),
       birth_mday = EXTRACT(DAY FROM birthday)
       WHERE birthday IS NOT NULL
    })
    end
  end

  def down
    if Rails.env != 'test'
      execute(%q{
      UPDATE customers SET birth_year = NULL,
       birth_month = NULL,
       birth_mday = NULL
    })
    end
  end
end
