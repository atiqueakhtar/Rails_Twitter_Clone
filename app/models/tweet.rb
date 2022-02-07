class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, class_name: "User", source: "user"

    has_many :retweets, dependent: :destroy
    has_many :retweeted_by, through: :retweets, class_name: "User", source: "user"

    validates :body, presence: true, length: { maximum: 100 }

    def liked_by?(user_id)
        self.liked_by.pluck(:id).include?(user_id)
    end

    def retweeted_by?(user_id)
        self.retweeted_by.pluck(:id).include?(user_id)
    end
end
