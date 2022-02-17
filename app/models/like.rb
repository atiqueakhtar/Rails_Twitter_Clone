class Like < ApplicationRecord
    belongs_to :tweet
    belongs_to :user
    has_many :notifications, as: :notifiable, dependent: :destroy
end