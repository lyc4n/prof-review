FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user#{n}@example.com"}
    first_name 'Norly'
    last_name  'Canarias'
    password              'password'
    password_confirmation 'password'
  end
end
