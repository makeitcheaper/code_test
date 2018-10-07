FactoryBot.define do
  factory :lead do
    name { Faker::Name.name }
    business_name  { Faker::Company.name }
    email { Faker::Internet.safe_email }
    telephone_number { Faker::Number.number(10) }
  end
end
