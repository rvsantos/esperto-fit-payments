class AddNameAndEmailToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :name, :string
    add_column :registrations, :email, :string
  end
end
