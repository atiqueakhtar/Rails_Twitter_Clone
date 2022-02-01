class Search < ApplicationRecord
    scope :published, -> { where(status: "public") }
    # scope :find_user, -> { find_by(user_id: params[:id]) }
    # scope :find_follower, -> { find_by(follower_id: Current.user.id) }
end