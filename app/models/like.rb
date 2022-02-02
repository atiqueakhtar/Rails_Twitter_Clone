class Like < ApplicationRecord
    belongs_to :tweet
    belongs_to :user

    def liked?(user_id)
        Tweet.find_by(id: user_id).liked_by.pluck(:id).include?(Current.user.id)
    end
end
