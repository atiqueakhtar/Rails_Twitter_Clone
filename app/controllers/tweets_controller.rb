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

    private
      def tweet_params
        params.require(:tweet).permit(:body)
      end
end
  