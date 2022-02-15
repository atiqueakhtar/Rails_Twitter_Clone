require 'rails_helper'

RSpec.describe Tweet, type: :model do
    describe '#retweets' do
        it 'returns array of retweets on a tweet' do
            tweet = create :parent_tweet

            sub_tweet1 = create(:tweet, :retweet, parent_tweet: tweet)
            sub_tweet2 = create(:tweet, :reply, parent_tweet: tweet)

            expect(tweet.retweets).not_to include(sub_tweet2)
            expect(tweet.retweets).to include(sub_tweet1)
        end
    end

    describe '#replies' do
        it 'returns array of replies on a tweet' do
            tweet = create :parent_tweet

            sub_tweet1 = create(:tweet, :retweet, parent_tweet: tweet)
            sub_tweet2 = create(:tweet, :reply, parent_tweet: tweet)

            expect(tweet.replies).to include(sub_tweet2)
            expect(tweet.replies).not_to include(sub_tweet1)
        end
    end

    describe '#liked_by?' do
        it 'finds if user likes a tweet' do
            like = create :like
            tweet = like.tweet

            user1 = like.user
            user2 = create :user 

            tweet_likes = create :tweet_with_likes, likes_count: 2

            expect(tweet_likes.liked_by.length).to eq(2)
            expect(tweet.liked_by?(user1.id)).to be true
            expect(tweet.liked_by?(user2.id)).to be false
        end
    end

    describe '#retweeted_by?' do
        it 'finds if user retweeted a tweet' do
            tweet = create :parent_tweet

            sub_tweet1 = create :tweet, :retweet, parent_tweet: tweet
            user1 = sub_tweet1.user

            sub_tweet2 = create :tweet, parent_tweet: tweet
            user2 = sub_tweet2.user

            expect(tweet.retweeted_by?(user1.id)).to be true
            expect(tweet.retweeted_by?(user2.id)).to be false
        end
    end
    
    describe '#get_retweet' do
        it 'finds retweet by a given user' do
            tweet = create :parent_tweet

            sub_tweet1 = create :tweet, :retweet, parent_tweet: tweet
            user1 = sub_tweet1.user

            sub_tweet2 = create :tweet, parent_tweet: tweet
            user2 = sub_tweet2.user

            expect(tweet.get_retweet(user1.id)).to eq(sub_tweet1)
            expect(tweet.get_retweet(user2.id)).not_to eq(sub_tweet2)
        end
    end
end
