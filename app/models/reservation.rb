class Reservation < ApplicationRecord
  belongs_to :bedroom
  belongs_to :user
end
