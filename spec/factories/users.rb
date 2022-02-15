FactoryBot.define do
    factory :user do
        sequence(:username) { |n| "user#{n}" }
        sequence(:email) { |n| "user#{n}@gmail.com" }
        password { "user@123" }
        password_confirmation { "user@123" }

        factory :user_with_followers do
            transient do
                followers_count { 5 }
            end
            after(:create) do |user, evaluator|
                create_list :relation, evaluator.followers_count, followee: user
            end
        end
    end
end