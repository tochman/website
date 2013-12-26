class Subject < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :bookings
  acts_as_followable
end
