# Read about factories at https://github.com/thoughtbot/factory_girl


MAX_COORDINATE = 179.9999999
MIN_COORDINATE = -179.9999999
def random_coordinate
  rand * (MAX_COORDINATE-MIN_COORDINATE) + MIN_COORDINATE
end

FactoryGirl.define do
  factory :location do
    coordinates   { { lat: random_coordinate, long: random_coordinate} }
  end
end
