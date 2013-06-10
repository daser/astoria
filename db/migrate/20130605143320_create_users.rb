class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.date :dob
      t.text :coyname
      t.string :position
      t.string :coyemail
      t.string :mobile
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
