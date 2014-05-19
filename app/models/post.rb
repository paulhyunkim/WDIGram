class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :caption, type: String
  field :tags, type: String
  field :likes, type: Integer, default: 0

  belongs_to :user
  has_many :comments
  has_mongoid_attached_file :picture,
  :styles => {
      :original => ['1920x1680>', :jpg, :convert_options => "-auto-orient", :quality => 100],
      :large    => ['600x600>',   :jpg, :convert_options => "-auto-orient", :quality => 100]
    }
    # :path           => ':picture/:id/:style.:extension',
    # :storage        => :s3,
    # # :url            => ':s3_alias_url',
    # # :s3_host_alias  => 'something.cloudfront.net',
    # :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
    
    # # :convert_options => { :all => '-background white -flatten +matte' }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :picture, :attachment_presence => true
  validates_length_of :caption, :maximum => 140
  validates_presence_of :caption

   def decide_style
    if picture_content_type =~ %r{^(image|(x-)?application)/(bmp|jpeg|jpg|pjpeg|png|x-png)$}
      "600x600>"
    else
      false
    end
  end

end

