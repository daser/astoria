class AddPaidflagToUser < ActiveRecord::Migration
  def change
    add_column :users, :paidflag, :integer,:null => false, :default => 0
  end
end
