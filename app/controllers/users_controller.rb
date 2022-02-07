class UsersController < ApplicationController

    before_action :get_user, only: [:followers, :show, :update]

    def followers
        @followers = @required_user.followers
    end

    def create
        if params[:username] == ""
            redirect_to root_path, notice: "Type username to search." 
        else
            @users = User.where("username LIKE '%#{params[:username]}%'")
        end 
    end

    def show
        @user = @required_user
        @tweets = @user.tweets.all
        @followers = @user.followers
    end

    def update
        if Current.user.followees?(params[:id])
            @required_user.followers.delete(Current.user)
            redirect_to user_path(params[:id]), notice: "Unfollowed successfully!"
        else
            @required_user.followers << Current.user
            redirect_to user_path(params[:id]), notice: "Followed successfully!"
        end
    end

    private
    def get_user
        @required_user = User.find_by(id: params[:id])
    end
end