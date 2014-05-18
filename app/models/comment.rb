class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  field :commenter, type: String

  belongs_to :user
  belongs_to :post

  validates_presence_of :content
	validates_length_of :content, :maximum => 140
end
