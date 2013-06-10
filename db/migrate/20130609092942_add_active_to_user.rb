class AddActiveToUser < ActiveRecord::Migration
  def change
    add_column :users, :active, :string,:null => false, :default => 0
  end
end
