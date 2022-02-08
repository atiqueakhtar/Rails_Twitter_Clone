class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, class_name: "User", source: "user"

    has_many :retweets, class_name: "Tweet", foreign_key: "parent_id", dependent: :destroy
    has_many :retweeted_by, through: :retweets, class_name: "User", source: :user
    # belongs_to :parent, class_name: "Tweet", foreign_key: "parent_id"

    scope :replies, ->(parent_id) { where(parent_id: parent_id).where(tweet_type: "reply") }
    scope :get_retweet, ->(current_user_id) { find_by(user_id: current_user_id, tweet_type: "retweet") }

    def liked_by?(user_id)
        self.liked_by.pluck(:id).include?(user_id)
    end

    def retweeted_by?(user_id)
        self.retweeted_by.pluck(:id).include?(user_id)
    end
end
