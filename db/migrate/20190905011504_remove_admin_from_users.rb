class RemoveAdminFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :admin, :string
    remove_column :users, :adm, :boolean
  end
end
