# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer, class: Answer, parent: :post do
    question { create(:question) }
  end
end
