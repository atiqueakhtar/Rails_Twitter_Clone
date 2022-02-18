class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(action_id, action_name)
    if action_name == "Like" 
      action = Like.find(action_id)
      action_tweet = action.tweet
    else
      action = Tweet.find(action_id)
      action_tweet = action.parent_tweet
    end
    Notification.create(notifiable: action, notifier_id: action_tweet.user_id) if action_tweet.user_id != action.user.id
  end
end
