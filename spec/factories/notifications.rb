FactoryBot.define do
    factory :notification do
        notifier_id { 1 }

        trait :for_like do
            association :notifiable, factory: :like
        end
        
        trait :for_tweet do
            association :notifiable, factory: :tweet 
        end
    end
end