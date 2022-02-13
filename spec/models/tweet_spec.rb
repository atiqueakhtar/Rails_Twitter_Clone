require 'rails_helper'

RSpec.describe Tweet, type: :model do
    describe '#retweets' do
        it 'returns array of retweets on a tweet' do
            tweet = create :parent_tweet

            sub_tweet1 = create(:tweet, parent_tweet: tweet, tweet_type: "retweet")
            sub_tweet2 = create(:tweet, parent_tweet: tweet, tweet_type: "reply")

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

    describe '#liked_by?' do
        it 'returns true if user likes a tweet and vice versa' do
            like = create :like
            tweet = like.tweet
            user = like.user

            expect(tweet.liked_by?(user.id)).to be true
        end
    end

    describe '#retweeted_by?' do
        it 'return true if user retweeted a tweet and vice versa' do
            tweet = create :parent_tweet

            sub_tweet1 = create :tweet, parent_tweet: tweet, tweet_type: "retweet"
            user1 = sub_tweet1.user

            sub_tweet2 = create :tweet, parent_tweet: tweet
            user2 = sub_tweet2.user

            expect(tweet.retweeted_by?(user1.id)).to be true
            expect(tweet.retweeted_by?(user2.id)).to be false
        end
    end
    
end
