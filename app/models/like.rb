class Like < ApplicationRecord
    after_create :create_notification

    belongs_to :tweet
    belongs_to :user
    has_many :notifications, as: :notifiable, dependent: :destroy

    private
    def create_notification
        CreateNotificationJob.perform_later(self)
    end
end