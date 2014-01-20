module Mongoid
  module Document
    def serializable_hash(options={})
      hash = super(except: :_id)
      hash["id"] = self.id.to_s
      hash
    end
  end
end
