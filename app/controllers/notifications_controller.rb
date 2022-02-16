class NotificationsController < ApplicationController
    def index
        @notifications = Notification.where(tweet_user_id: Current.user.id)
    end
end