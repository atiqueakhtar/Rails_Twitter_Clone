class TweetsController < ApplicationController
    def index
      @tweets = Tweet.all
    end
    
    def show
      @tweet = Tweet.find(params[:id])
    end

    def new
      require_user_logged_in! unless session[:user_id]
      @tweet = Tweet.new
    end

    def create
      @tweet = Tweet.new(body: params[:body], user_id: Current.user.id)
  
      if @tweet.save
        redirect_to root_path, notice: "Tweet created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @tweet = Tweet.find(params[:id])
    end
  
    def update
      @tweet = Tweet.find(params[:id])
  
      if @tweet.update(tweet_params)
        redirect_to @tweet, notice: "Status updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
  
      redirect_to root_path, notice: "Tweet deleted successfully!"
    end

    def handle_like
      if Tweet.find_by(id: params[:tweet_id]).likes.pluck(:user_id).include?(Current.user.id)
        Like.find_by(tweet_id: params[:tweet_id], user_id: Current.user.id).destroy
        redirect_to root_path, notice: "Tweet unliked successfully!"
      else
        @like = Like.create(user_id: Current.user.id, tweet_id: params[:tweet_id])
        redirect_to root_path, notice: "Tweet liked successfully!"
      end
    end

    private
      def tweet_params
        params.require(:tweet).permit(:body)
      end
end
  