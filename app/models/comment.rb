class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  # validates :commenter, presence: true
  validates :body, presence: true
end
