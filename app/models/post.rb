class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :caption, type: String
  field :tags, type: String
  field :likes, type: Integer, default: 0

  belongs_to :user
  has_many :comments
  has_mongoid_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  # def duration
  #   (Time.now - self.created_at).to_i.to_s
  # end

end

