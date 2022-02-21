module TweetsHelper
    def tweet_creation_time(tweet)
        content_tag :small, class: "font-weight-light" do
            tweet.created_at.localtime.strftime("%B %e, %Y %I:%M %p")
        end
    end
end