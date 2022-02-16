class Notification < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :notifiable, polymorphic: true

  def create(tweet)
    create_notification(tweet)
  end
  private
    def create_notification(tweet)
      Notification.create(notifiable: self, tweet_user_id: tweet.user_id)
    end
end
