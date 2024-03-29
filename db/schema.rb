# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130610120040) do

  create_table "invitations", :force => true do |t|
    t.integer  "invited",    :default => 0, :null => false
    t.integer  "invitee"
    t.string   "email"
    t.integer  "signupflag", :default => 0, :null => false
    t.datetime "invitedate"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "name"
  end

  create_table "users", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.date     "dob"
    t.text     "coyname"
    t.string   "position"
    t.string   "coyemail"
    t.string   "mobile"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "mname"
    t.integer  "approve",                :default => 0,   :null => false
    t.integer  "accessflag",             :default => 0,   :null => false
    t.integer  "paidflag",               :default => 0,   :null => false
    t.string   "activation_token"
    t.string   "active",                 :default => "0", :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
