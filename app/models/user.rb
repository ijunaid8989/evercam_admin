class User < ApplicationRecord
  establish_connection "evercam_db_#{Rails.env}".to_sym
  before_save :add_missing_fields
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def add_missing_fields
    self["password"] = self.encrypted_password
    self["username"] = self.email
  end
end
