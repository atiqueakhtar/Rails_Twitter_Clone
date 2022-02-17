class NotificationsController < ApplicationController
    helper DisplayNotificationHelper

    def index
        @notifications = Current.user.notifications
    end
end