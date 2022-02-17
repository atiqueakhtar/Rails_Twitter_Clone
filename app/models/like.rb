class Like < ApplicationRecord
    after_create :create_notification

    belongs_to :tweet
    belongs_to :user
    has_many :notifications, as: :notifiable, dependent: :destroy

    private
    def create_notification
        Notification.create(notifiable: self, notifier_id: self.tweet.user_id) if self.tweet.user_id != self.user.id
    end
end