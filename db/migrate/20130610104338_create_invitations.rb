class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invited, :null => false, :default => 0
      t.integer :invitee
      t.string :email
      t.integer :signupflag,:null => false, :default => 0
      t.datetime :invitedate

      t.timestamps
    end
  end
end
