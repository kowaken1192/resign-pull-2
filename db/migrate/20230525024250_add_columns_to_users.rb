class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    def change
      add_column :users, :profile, :text
      add_column :users, :avatar, :string
  end
end
