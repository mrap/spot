# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :foursquare_place do

    factory :foursquare_place_chipotle do
      name           "Chipotle Mexican Grill"
      foursquare_id  "4d363111fe972c0fc8bc9ab3"
      address        "990 Serramonte Blvd"
      locality       "Colma"
      region         "CA"
      country        "United States"
      coordinates    {{ latitude: 37.671170138534265, longitude: -122.46435552835464 }}
    end

  end
end
