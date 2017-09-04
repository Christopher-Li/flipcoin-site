class User < ApplicationRecord
  # include ActiveModel::Validations
  # validates_with BitcoinAddressValidator :bitAdd
  attr_accessor :activation_token
	before_save :downcase_email
  before_create :create_activation_digest
  before_create :create_contract_digest
	validates :firstName, presence: true, length: {maximum: 20}
	validates :lastName, presence: true, length: {maximum: 20}
	validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
		presence: true,
		uniqueness: {case_sensitive: false},
		length: {maximum: 50}
	has_secure_password
	validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :estimatedContribution, presence: true
  validates :address1, presence: true
  validates :zipCode, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :dob, presence: true
  validates :isEntity, presence: true
  validates :organizationType, presence: true
  validates :citizenship, presence: true
  # validates :ethAdd, allow_nil: true, length: {is: 42}

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sends Thank you email
  def send_thank_you_email
    UserMailer.thank_you(self).deliver_now
  end
  
  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def create_contract_digest
      self.contract_digest = SecureRandom.hex
    end

    def validate(record)
      unless record.ethAdd.starts_with? '0x'
        record.errors[:ethAdd] << "Need address starting with '0x'!"
      end
    end
end


# class MyValidator < ActiveModel::Validator
#   def validate(record)
#     unless record.ethAdd.starts_with? '0x'
#       record.errors[:ethAdd] << "Need address starting with '0x'!"
#     end
#     unless record.bitAdd.starts_with? '0x'
#       record.errors[:ethAdd] << "Need address starting with '0x'!"
#     end
#   end
# end
