class Tweet < ApplicationRecord
    has_many :comments
    has_many :likes
    belongs_to :user

    validates :body, presence: true, length: { maximum: 30 }

    scope :published, -> { where(status: "public") }
    scope :other_users, -> { where("user_id != ?", Current.user.id,) }
end
