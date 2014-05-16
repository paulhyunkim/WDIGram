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
    :path           => ':picture/:id/:style.:extension',
    :storage        => :s3,
    # :url            => ':s3_alias_url',
    # :s3_host_alias  => 'something.cloudfront.net',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
    # :styles => {
    #   :original => ['1920x1680>', :jpg],
    #   :small    => ['100x100#',   :jpg],
    #   :medium   => ['250x250',    :jpg],
    #   :large    => ['500x500>',   :jpg]
    # },
    # :convert_options => { :all => '-background white -flatten +matte' }
  # validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  # def duration
  #   (Time.now - self.created_at).to_i.to_s
  # end

end

