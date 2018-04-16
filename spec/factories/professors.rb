FactoryBot.define do
  factory :professor do
    first_name {Faker::Ancient.hero}
    last_name  {Faker::Name.last_name}
  end
end
