require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username is present' do
      user = build(:user, username: nil)
      expect(user.save).to eq(false)
    end

    it 'ensures email is present' do
      user = build(:user, email: nil)
      expect(user.save).to eq(false)
    end

    it 'ensures user creates on proper input' do
      user = create :user
      expect(user.save).to eq(true)
    end
  end

  describe '#followed_by?' do
    it 'finds if a user is a follower' do
      relation = create :relation

      follower = relation.follower
      followee = relation.followee

      expect(followee.followed_by?(follower.id)).to be true
      expect(follower.followed_by?(followee.id)).to be false
    end
  end

  describe '#followee?' do
    it 'finds if a user is a followee' do
      relation = create :relation

      follower = relation.follower
      followee = relation.followee

      expect(follower.followee?(followee.id)).to be true
      expect(followee.followee?(follower.id)).to be false
    end
  end

  describe '#notification' do
    it 'returns all notifications of current user' do
      tweet = create :tweet
      Current.user = create :user
      like = create :like, tweet: tweet, user: Current.user
      reply = create :tweet, :reply, parent_tweet: tweet, user: Current.user

      notify1 = create :notification, notifiable: reply, notifier_id: tweet.user.id
      notify2 = create :notification, notifiable: like, notifier_id: tweet.user.id
      
      expect(tweet.user.notifications).to match_array([notify1, notify2])
    end
  end
end
