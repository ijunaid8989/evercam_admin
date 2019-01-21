class Country < ActiveRecord::Base
  establish_connection "evercam_db_#{Rails.env}".to_sym

  validates :name, presence: true
  validates :iso3166_a2, presence: true
end
