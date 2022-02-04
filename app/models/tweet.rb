class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, class_name: "User", source: "user"

    validates :body, presence: true, length: { maximum: 100 }

    def liked?(tweet_id)
        Tweet.find_by(id: tweet_id).liked_by.pluck(:id).include?(Current.user.id)
    end
end
