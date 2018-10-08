FactoryBot.define do
  factory :lead do
    name {"#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    business_name  { Faker::Company.name }
    email { Faker::Internet.safe_email }
    telephone_number { '01344123123' }
    contact_time { DateTime.now.to_s(:db) }

    trait :internal do
      access_token { ENV['LEAD_API_ACCESS_TOKEN'] }
      pGUID { ENV['LEAD_API_PGUID'] }
      pAccName { ENV['LEAD_API_PACCNAME'] }
      pPartner{ ENV['LEAD_API_PPARTNER']}
    end
  end
end
