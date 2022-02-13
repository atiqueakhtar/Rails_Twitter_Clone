FactoryBot.define do
    factory :tweet do
        body { "dummy tweet body" }
        association :parent_tweet, factory: :parent_tweet
        tweet_type { "tweet" }
        user
    end

    factory :parent_tweet, class: Tweet do
        body { "dummy parent tweet body" }
        parent_tweet_id { nil }
        tweet_type { "tweet" }
        user
    end
end