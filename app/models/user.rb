class User < ApplicationRecord
	include AASM
	include BCrypt

	has_many :movies

	mount_uploader :avatar, AvatarUploader
	
	validates_uniqueness_of :email
	validates_presence_of :email, :name, :last_name, :password
	validates_confirmation_of :password, on: :create
	validates_presence_of :password_confirmation, if: :password_changed?

	before_create :encrypt_password

	aasm column: "status", skip_validation_on_save: true do
		state :active, initial: true
		state :inactive
		state :blocked

		event :disable do 
			transitions from: :active, to: :inactive
		end
		event :enable do
			transitions from: [:inactive, :blocked], to: :active
		end
	end

	def validate_password(insecure)
		Password.new(self.password) == insecure
	end

	def profile_details
    {
      name: name, last_name: last_name, email: email, avatar: avatar.url, phone: phone
    }
  end

	private
		def encrypt_password
			self.password = Password.create(password)
		end
end
