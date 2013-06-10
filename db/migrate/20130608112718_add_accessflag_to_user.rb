class AddAccessflagToUser < ActiveRecord::Migration
  def change
    add_column :users, :accessflag, :integer,:null => false, :default => 0
  end
end
