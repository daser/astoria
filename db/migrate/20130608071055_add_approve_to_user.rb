class AddApproveToUser < ActiveRecord::Migration
  def change
    add_column :users, :approve, :integer,:null => false, :default => 0
  end
end
