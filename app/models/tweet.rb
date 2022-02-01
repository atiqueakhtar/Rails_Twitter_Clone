class Tweet < ApplicationRecord
    has_many :comments
    belongs_to :user
    has_many :likes
    has_many :liked_by, through: :likes, class_name: "User", source: "user"

    validates :body, presence: true, length: { maximum: 30 }

    scope :published, -> { where(status: "public") }
    scope :other_users, -> { where("user_id != ?", Current.user.id,) }
end
