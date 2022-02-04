class LikesController < ApplicationController
    before_action :get_tweet, only: [:index, :create]

    def index 
        @users = @tweet.liked_by
    end

    def create
        respond_to do |format|
            if Like.new.liked?(params[:tweet_id])
                @tweet.liked_by.delete(Current.user)
                format.turbo_stream
                format.html { redirect_to root_path, notice: "Tweet unliked successfully!" }
            else
                @tweet.liked_by << Current.user
                format.turbo_stream
                format.html { redirect_to root_path, notice: "Tweet liked successfully!" }
            end
        end
    end

    private 
    def get_tweet
        @tweet = Tweet.find_by(id: params[:tweet_id])
    end
end