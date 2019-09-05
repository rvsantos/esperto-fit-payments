class AddValueAndDateToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :value, :float
    add_column :payments, :due_date, :date
  end
end
