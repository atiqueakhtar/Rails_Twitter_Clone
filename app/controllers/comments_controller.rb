class CommentsController < ApplicationController
    before_action :require_user_logged_in!
    def create
      @tweet = Tweet.find(params[:tweet_id])

      @comment = @tweet.comments.new(body: params[:comment][:body], user_id: Current.user.id)

      if @comment.save
        redirect_to tweet_path(@tweet), notice: "comment successfully added!"
      else
        redirect_to tweet_path(@tweet), alert: "comment not added, write something to add comment!"
      end
    end
  
    private
      def comment_params
        params.require(:comment).permit(:commenter, :body)
      end
end
  