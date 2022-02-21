require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
    describe "GET /index" do
        it 'returns all notifications for a user' do
            tweet = create :tweet
            Current.user = create :user
            tweet_like = create :like, tweet: tweet, user: Current.user
            notify = create :notification, notifiable: tweet_like, notifier_id: tweet.user.id

            get :index

            expect(assigns(:notifications)).to match_array([notify])
        end
    end
end