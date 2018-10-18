FactoryBot.define do
  factory :lead, aliases: [:lead_thomas] do
    full_name { 'John Doe' }
    business_name { 'MakeItCheaper' }
    email { 'john@makeitcheaper.com' }
    phone_number { '07943123321' }
  end
end
