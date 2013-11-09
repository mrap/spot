class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :user
  belongs_to :post

  field :description
  has_mongoid_attached_file :photo,
    default_style: :medium,
    styles: {
      medium: ['600x600>',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' },
    dependent: :destroy

end
