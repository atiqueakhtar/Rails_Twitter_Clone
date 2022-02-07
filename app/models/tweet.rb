class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, class_name: "User", source: "user"

    # validates :body, presence: true, length: { maximum: 100 }
    has_many :retweets, class_name: "Tweet", foreign_key: "parent_id", dependent: :destroy
    has_many :retweeted_by, through: :retweets, class_name: "User", source: :user
    # scope :retweeted?, ->(parent_id) { where(user_id: Current.user.id).where(parent_id: parent_id) }
    # scope :retweets, ->(parent_id) { where(parent_id: parent_id) }

    def liked_by?(user_id)
        self.liked_by.pluck(:id).include?(user_id)
    end

    def retweeted_by?(user_id)
        self.retweeted_by.pluck(:id).include?(user_id)
    end

end
