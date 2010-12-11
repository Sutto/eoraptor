class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
