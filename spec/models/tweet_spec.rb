require 'rails_helper'

RSpec.describe Tweet, type: :model do
    describe '#retweets' do
     it 'returns array of retweets on a tweet' do
        tweet = Tweet.create!(body: "tweet test body", user_id: 3, tweet_type: "tweet")
        sub_tweet1 = Tweet.create!(user_id: 4, parent_tweet_id: tweet.id, tweet_type: "retweet")
        sub_tweet2 = Tweet.create!(body: "reply test body", user_id: 4, parent_tweet_id: tweet.id, tweet_type: "reply")

        expect(tweet.retweets).to eq([sub_tweet1])
     end
    end

end