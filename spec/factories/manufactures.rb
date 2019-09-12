FactoryBot.define do
  factory :manufacture do
    sequence(:name) { |n| "Montadora #{n}" }
  end
end
