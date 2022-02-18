class CreateNotificationJob < ApplicationJob
  queue_as :default

  def perform(action_id, action_type)
    debugger
    action = action_type.constantize.find_by(id: action_id)
    return unless action  
        
    action_tweet = action.try(:tweet) || action.try(:parent_tweet)

    Notification.create(notifiable: action, notifier_id: action_tweet.user_id)
  end
end
