class Article < ApplicationRecord
validates :text_hash, :presence => true, :uniqueness => true

	def self.search(search)
		if search
			self.where('text like ?', "%#{search}%")
		else
			self.all
		end
	end

end
