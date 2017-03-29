class Cost < ApplicationRecord
	has_one :image
	accepts_nested_attributes_for :image
	def obtener_imagen
		self.image || Image.new
	end
	def get_cover_url
		image.try(:cover_url) || "http://res.cloudinary.com/dboxtzegl/image/upload/v1488331135/photo_v0myys.png"
	end
end
