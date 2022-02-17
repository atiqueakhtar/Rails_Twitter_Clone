class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(action)
    if action.class.name == "Like"
      Notification.create(notifiable: action, notifier_id: action.tweet.user_id) if action.tweet.user_id != action.user.id
    else
      Notification.create(notifiable: action, notifier_id: action.parent_tweet.user_id) if action.parent_tweet.user_id != action.user.id
    end
  end
end
