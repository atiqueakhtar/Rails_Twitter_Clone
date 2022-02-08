class RepliesController < ApplicationController
    before_action :get_tweet, only: [:create]

    def create
        @reply = Tweet.new(body: params[:body], user_id: Current.user.id, parent_id: @tweet.id, tweet_type: "reply")
        if @reply.save
          redirect_to tweet_path(@tweet.id), notice: "Reply added successfully!"
        else
          render :new, status: :unprocessable_entity
        end

    end

    private
    def get_tweet
        @tweet = Tweet.find_by(id: params[:tweet_id])
    end
end