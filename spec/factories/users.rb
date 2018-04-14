FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user#{n}@example.com"}
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.last_name}
    password              'password'
    password_confirmation 'password'
  end
end
