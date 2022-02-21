class Like < ApplicationRecord
    after_commit :create_notification, on: :create

    belongs_to :tweet
    belongs_to :user
    has_one :notification, as: :notifiable, dependent: :destroy

    private
    def create_notification
        CreateNotificationJob.perform_later(self.id, self.class.to_s) if self.user != self.tweet.user
    end
end