class NotificationsController < ApplicationController

    def index
        @notifications = Current.user.notifications
    end
end