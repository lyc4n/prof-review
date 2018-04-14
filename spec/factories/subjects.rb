FactoryBot.define do
  factory :subject do
    code {"#{Faker::ProgrammingLanguage.name} #{Faker::Number.between(111, 999)}" }

    transient do
      professors_count 5
    end

    trait(:with_professor) do
      after(:create) do |user, evaluator|
        create_list(:professor, evaluator.professors_count)
      end
    end
  end
end
