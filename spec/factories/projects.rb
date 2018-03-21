FactoryBot.define do
  factory :project do
    user
    name "Leaning tower of Piza"
    description "This is the coolest tower in the whole world. I took this shot in the Spring of 2015."
    
    factory :project_with_uploads do
      transient do
        uploads_count 1
      end

      after(:create) do |project, evaluator|
        create_list(:upload, evaluator.uploads_count, project: project)
      end
    end

  end
end
