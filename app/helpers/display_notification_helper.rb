module DisplayNotificationHelper
    def display_notification(notification)
        if notification.notifiable_type == "Like"
            link_to "You have a #{notification.notifiable_type} by #{notification.notifiable.user.username} on your tweet", tweet_path(notification.notifiable.tweet_id)
        else
            link_to "You have a #{notification.notifiable.tweet_type} by #{notification.notifiable.user.username} on your tweet", tweet_path(notification.notifiable.parent_tweet_id)
        end
    end
end