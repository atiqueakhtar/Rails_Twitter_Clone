class Like < ApplicationRecord
    after_create :create_notification

    belongs_to :tweet
    belongs_to :user
    has_many :notifications, as: :notifiable, dependent: :destroy

    private
    def create_notification
        Notification.create(notifiable: self, tweet_user_id: self.tweet_id) if self.user_id != Current.user.id
    end
end