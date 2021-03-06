FactoryBot.define do
  factory :subject do
    code {"#{Faker::ProgrammingLanguage.name} #{Faker::Number.unique.between(111, 999)}" }

    transient do
      professors_count 5
    end

    trait(:with_professor) do
      after(:create) do |subject, evaluator|
        create_list(:professor, evaluator.professors_count, subject_ids: [subject.id])
      end
    end
  end
end
