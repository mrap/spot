module Mongoid
  module Document
    def serializable_hash(options={})
      hash = super(except: [:_id, :created_at, :updated_at])
      hash["id"] = self.id.to_s
      hash
    end
  end
end
