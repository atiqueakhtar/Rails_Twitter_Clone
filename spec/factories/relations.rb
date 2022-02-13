FactoryBot.define do
    factory :relation do
        association :follower, factory: :user
        association :followee, factory: :user
    end
end