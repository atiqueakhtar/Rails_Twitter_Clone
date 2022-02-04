class Like < ApplicationRecord
    belongs_to :tweet
    belongs_to :user

    def liked?(tweet_id)
        Tweet.find_by(id: tweet_id).liked_by.pluck(:id).include?(Current.user.id)
    end
end
