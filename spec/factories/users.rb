FactoryBot.define do
    factory :user do
        sequence(:username) { |n| "abc#{n}" }
        sequence(:email) { |n| "abc#{n}@gmail.com" }
        password { "abc@123" }
        password_confirmation { "abc@123" }
    end
end