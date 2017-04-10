class Payment < ApplicationRecord
  belongs_to :reservation
  validates :value, :presence => true, inclusion: (1..99999999999999999999)
end
