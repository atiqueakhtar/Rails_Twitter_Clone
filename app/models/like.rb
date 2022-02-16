class Like < ApplicationRecord
    belongs_to :tweet
    belongs_to :user
    has_many :notifications, as: :notifiable, dependent: :destroy

    def create_notification(tweet)
        create(tweet)
    end

    private
    def create(tweet)
        Notification.create(notifiable: self, tweet_user_id: tweet.user_id)
    end
end