FactoryBot.define do
  factory :lead do
    name {"#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    business_name  { Faker::Company.name }
    email { Faker::Internet.safe_email }
    telephone_number { Faker::Number.number(12) }
    contact_time { DateTime.now.to_s(:db) }
  end
end
