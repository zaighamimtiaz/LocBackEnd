class User < ApplicationRecord
	has_many :locations

	validates :emailid, uniqueness: true
end
