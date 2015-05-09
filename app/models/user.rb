class User < ActiveRecord::Base
	has_secure_password

	has_many :tasks, dependent: :destroy

	validates :email, presence: true, length: { maximum: 255 },
										format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
										uniqueness: { case_sensitive: false }

	validates :password, presence: true, length: { minimum: 3 }

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def create_authenticate_token
		token = User.new_token
		self.update_attribute(:authenticate_token, token)
		token
	end
end
