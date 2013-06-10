class AddMnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mname, :string
  end
end
