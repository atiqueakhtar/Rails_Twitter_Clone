class Tweet < ApplicationRecord
    belongs_to :user, optional: true
    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, class_name: "User", source: "user"
    has_many :notifications, as: :notifiable, dependent: :destroy

    has_many :child_tweets, class_name: "Tweet", foreign_key: "parent_tweet_id", dependent: :destroy
    has_many :retweeted_by, through: :child_tweets, class_name: "User", source: :user
    belongs_to :parent_tweet, class_name: "Tweet", foreign_key: "parent_tweet_id", optional: true

    default_scope { order(:created_at) }

    def liked_by?(user_id)
        self.liked_by.pluck(:id).include?(user_id)
    end

    def get_retweet(user_id)
        Tweet.find_by(user_id: user_id, tweet_type: "retweet", parent_tweet_id: self.id)
    end

    def retweeted_by?(user_id)
        retweets.pluck(:user_id).include?(user_id)
    end

    def retweets
        self.child_tweets.where(tweet_type: "retweet")
    end

    def replies
        self.child_tweets.where(tweet_type: "reply")
    end

end
