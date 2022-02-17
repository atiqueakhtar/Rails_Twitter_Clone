class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(action)
    action_tweet = action.try(:tweet) || action.try(:parent_tweet)
    Notification.create(notifiable: action, notifier_id: action_tweet.user_id) if action_tweet.user_id != action.user.id
  end
end
