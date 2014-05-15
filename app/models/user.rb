require "bcrypt"
class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  before_save { self.email = email.downcase }
  before_save { self.firstName = firstName.capitalize }
  before_save { self.lastName = lastName.capitalize }
  before_create :create_remember_token
  field :firstName, type: String
  field :lastName, type: String
  field :email, type: String
  field :about, type: String
  field :password_digest, type: String
  field :remember_token, type: String

  has_many :posts
  has_many :comments

  validates :firstName, presence: true, length: { maximum: 50 }
  validates :lastName, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

  def password
    @password
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(test_password)
    if BCrypt::Password.new(self.password_digest) == test_password
      self
    else
      false
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
