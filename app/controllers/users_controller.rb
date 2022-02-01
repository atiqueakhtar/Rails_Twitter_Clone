class UsersController < ApplicationController
    def create
        if params[:username] == ""
            redirect_to root_path, notice: "Type username to search." 
        else
            @users = User.where("username LIKE '%#{params[:username]}%'")
        end 
    end

    def show
        @user = User.find_by(id: params[:id])
        @tweets = @user.tweets.all
        @followers = @user.followers
    end

    def update
        @user_followers = User.find_by(id: params[:id]).followers.pluck(:follower_id)
        if @user_followers.include? Current.user.id
            Follower.find_by(user_id: params[:id], follower_id: Current.user.id).destroy
            redirect_to user_path(params[:id]), notice: "Unfollowed successfully!"
        else
            Follower.create(user_id: params[:id], follower_id: Current.user.id)
            redirect_to user_path(params[:id]), notice: "Followed successfully!"
        end
    end
end