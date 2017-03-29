class Image < ApplicationRecord
  belongs_to :bedroom, optional: true
  belongs_to :cost, optional: true
  mount_uploader :cover, ImageUploader
end
