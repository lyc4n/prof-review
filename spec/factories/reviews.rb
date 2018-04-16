FactoryBot.define do
  factory :review do
    rating {Review::VALID_RATINGS.to_a.sample}
    description {Faker::Lorem.paragraph(2)}
  end
end
