require "bcrypt"
class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::Paperclip

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
  has_mongoid_attached_file :picture,
     :styles => {
      :original => ['1920x1680>', :jpg, :convert_options => "-auto-orient"],
      :small    => ['100x100#',   :jpg, :convert_options => "-auto-orient"],
      :medium   => ['250x250',    :jpg, :convert_options => "-auto-orient"],
      :large    => ['600x600>',   :jpg, :convert_options => "-auto-orient"]
    }
  
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates_attachment :picture, :presence => true

  validates :firstName, presence: true, length: { maximum: 50 }
  validates :lastName, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

 

end
