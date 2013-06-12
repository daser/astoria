class Invitation < ActiveRecord::Base
  attr_accessible :email, :invited, :invitedate, :invitee, :signupflag,:name
  validates :email, :presence=> {:message => 'Email is a compulsory field'}
  validates :invitee, :presence=> {:message => 'User needs to signup'}
  validates :name, :presence=> {:message => 'Name is required'}



end
