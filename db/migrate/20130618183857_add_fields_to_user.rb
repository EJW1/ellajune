class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :website, :string
    add_column :users, :birthday, :date
  end
end
