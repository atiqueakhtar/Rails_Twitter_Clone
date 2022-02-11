require 'rails_helper'

RSpec.describe Tweet, type: :model do
    describe '#retweets' do
        it 'returns array of retweets on a tweet' do
            tweet = create :parent_tweet
            sub_tweet1 = create(:tweet, parent_tweet: tweet, tweet_type: "retweet")
            sub_tweet2 = create(:tweet, parent_tweet: tweet, tweet_type: "reply")

            expect(tweet.retweets).to match_array([sub_tweet1])
            expect(tweet.retweets).not_to include(sub_tweet2)
        end
    end

    describe '#replies' do
        it 'returns array of replies on a tweet' do
            tweet = create :parent_tweet
            sub_tweet1 = create(:tweet, parent_tweet: tweet, tweet_type: "retweet")
            sub_tweet2 = create(:tweet, parent_tweet: tweet, tweet_type: "reply")

            expect(tweet.replies).to include(sub_tweet2)
        end
    end

    
end