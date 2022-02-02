class LikesController < ApplicationController
    before_action :get_tweet, only: [:index, :create]

    def index 
        @users = @tweet.liked_by
    end

    def create
        if @tweet.likes.pluck(:user_id).include?(Current.user.id)
            Like.find_by(tweet_id: params[:tweet_id], user_id: Current.user.id).destroy
            redirect_to root_path, notice: "Tweet unliked successfully!"
        else
            @like = Like.create(user_id: Current.user.id, tweet_id: params[:tweet_id])
            redirect_to root_path, notice: "Tweet liked successfully!"
        end
    end

    private 
    def get_tweet
        @tweet = Tweet.find_by(id: params[:tweet_id])
    end
end