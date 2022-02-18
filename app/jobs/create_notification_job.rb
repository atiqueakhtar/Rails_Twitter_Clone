class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(action_id, action_type)
    if action_type == "Like" 
      action = Like.find(action_id)
      action_tweet = action.tweet
    else
      action = Tweet.find(action_id)
      action_tweet = action.parent_tweet
    end
    Notification.create(notifiable: action, notifier_id: action_tweet.user_id)
  end
end
