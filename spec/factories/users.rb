FactoryBot.define do
    factory :user do
        username { "abc" }
        email { "abc@gmail.com" }
        password { "abc@123" }
        password_confirmation { "abc@123" }
    end
end