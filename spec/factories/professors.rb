FactoryBot.define do
  factory :professor do
    first_name {Faker::LordOfTheRings.character}
    last_name  {Faker::OnePiece.location}
  end
end
