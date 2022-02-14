FactoryBot.define do
    factory :tweet do
        body { "dummy tweet body" }
        association :parent_tweet, factory: :parent_tweet
        tweet_type { "tweet" }
        user

        trait :retweet do
            tweet_type { "retweet" }
        end

        trait :reply do
            tweet_type { "reply" }
        end
        
        factory :tweet_with_likes do
            transient do
                likes_count { 5 }
            end

            after(:create) do |tweet, evaluator|
                # evaluator.likes_count.times do 
                #     create :like, tweet: tweet
                # end
                create_list :like, evaluator.likes_count, tweet: tweet
            end

        end

    end


    factory :parent_tweet, class: Tweet do
        body { "dummy parent tweet body" }
        parent_tweet_id { nil }
        tweet_type { "tweet" }
        user
    end
end