class FactualPlace < Place
  include Mongoid::Document

  field :factual_id,      type: String
  field :category_labels, type: Array
  field :hours,           type: String
  field :tel,             type: String

  validates_presence_of :factual_id

end
