require 'spec_helper'

describe FactualPlace do
  it { should be_kind_of(Place) }

  # Fields
  it { should have_fields :factual_id,
                          :category_labels,
                          :hours,
                          :tel }

  # Validations
  it { should validate_presence_of :factual_id }
end
