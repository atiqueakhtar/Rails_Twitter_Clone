class Relation < ApplicationRecord
    #  followed_id
    #  follower_id
      belongs_to :follower, class_name: “User”, inverse_of: :relations
    #   belongs_to :followed, class_name: “User”, source: "user"
end