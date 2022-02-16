class TweetsController < ApplicationController

    before_action :get_tweet, only: [:likes, :add_like, :retweets, :update_retweet, :show, :add_reply]

    def index
      if session[:user_id]
        @tweets = Current.user.followees_and_user_tweets
      else
        @tweets = Tweet.all
      end
    end
  
    def show
      @tweet = Tweet.find(@tweet.id)
      @replies = @tweet.replies
    end

    def create
      @tweet = Tweet.new(body: params[:body], user_id: Current.user.id, tweet_type: "tweet")
      if params[:body] != "" && @tweet.save
        redirect_to root_path, notice: "Tweet created successfully!"
      else
        redirect_to root_path, alert: "Tweet body can't be empty"
      end
    end
  
    def destroy
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Tweet deleted successfully!" }
        format.json { head :no_content }
        format.js { render :layout => false }
      end
    end

    def likes 
        @users = @tweet.liked_by
    end

    def add_like
        respond_to do |format|
            if @tweet.liked_by?(Current.user.id)
                @tweet.liked_by.delete(Current.user)
                format.turbo_stream
                format.html { redirect_to root_path, notice: "Tweet unliked successfully!" }
            else
                @like = Like.create(tweet_id: @tweet.id, user_id: Current.user.id)
                @like.create_notification(@tweet) if @tweet.user_id != Current.user.id
                format.turbo_stream
                format.html { redirect_to root_path, notice: "Tweet liked successfully!" }
            end
        end
    end

    def retweets 
      @tweets = @tweet.retweets
    end

    def update_retweet
        if @tweet.retweeted_by?(Current.user.id)
          @tweet.get_retweet(Current.user.id).destroy
          redirect_to root_path, notice: "Retweet removed successfully!"
        else
          @retweet = Tweet.create(user_id: Current.user.id, parent_tweet_id: @tweet.id, tweet_type: "retweet")
          @retweet.create_notification(@tweet) if @tweet.user_id != Current.user.id
          redirect_to root_path, notice: "Retweeted successfully!"
        end
    end
    
    def add_reply
        @reply = Tweet.new(body: tweet_params[:body], user_id: Current.user.id, parent_tweet_id: @tweet.id, tweet_type: "reply")
        @reply.create_notification(@tweet) if @tweet.user_id != Current.user.id
        if @reply.save
          redirect_to tweet_path(@tweet.id), notice: "Reply added successfully!"
        else
          render :new, status: :unprocessable_entity
        end
    end

    private
      def tweet_params
        params.permit(:body)
      end

      def get_tweet
        @tweet = Tweet.find_by(id: params[:id])
      end
end
