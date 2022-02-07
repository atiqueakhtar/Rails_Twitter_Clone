class TweetsController < ApplicationController

    before_action :get_tweet, only: [:likes, :add_like]

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
      respond_to do |format|
        if @tweet.save
          format.turbo_stream
          format.html { redirect_to root_path, notice: "Tweet created successfully!" }
        else
          render :new, status: :unprocessable_entity
        end
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
                @tweet.liked_by << Current.user
                format.turbo_stream
                format.html { redirect_to root_path, notice: "Tweet liked successfully!" }
            end
        end
    end
    
    private
      def tweet_params
        params.require(:tweet).permit(:body)
      end

      def get_tweet
        @tweet = Tweet.find_by(id: params[:id])
    end
end
  