FactoryBot.define do
  factory :lead, aliases: [:lead_thomas] do
    full_name { 'Thomas' }
    business_name { 'MakeItCheaper' }
    email { 'thomas@makeitcheaper.com' }
    phone_number { '07943123321' }
  end
end
