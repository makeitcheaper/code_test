# frozen_string_literal: true

FactoryBot.define do
  factory :lead do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    business_name { Faker::Company.name }
    telephone_number '07123456789'
  end
end
