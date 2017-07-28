class User < ApplicationRecord
	before_save {self.email = email.downcase }
	validates :firstName, presence: true, length: {maximum: 20}
	validates :lastName, presence: true, length: {maximum: 20}
	validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
		presence: true,
		uniqueness: {case_sensitive: false},
		length: {maximum: 50}
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }
end
