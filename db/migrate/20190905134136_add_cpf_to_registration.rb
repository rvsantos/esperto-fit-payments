class AddCpfToRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :cpf, :string
  end
end
