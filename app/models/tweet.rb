class Tweet < ApplicationRecord
    belongs_to :user, optional: true
    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, class_name: "User", source: "user"

    has_many :child_tweets, class_name: "Tweet", foreign_key: "parent_tweet_id", dependent: :destroy
    has_many :retweeted_by, through: :child_tweets, class_name: "User", source: :user
    belongs_to :parent_tweet, class_name: "Tweet", foreign_key: "parent_tweet_id", optional: true

    scope :get_retweet, ->(current_user_id) { find_by(user_id: current_user_id, tweet_type: "retweet") }

    def liked_by?(user_id)
        self.liked_by.pluck(:id).include?(user_id)
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
