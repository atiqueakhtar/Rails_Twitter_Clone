# email:string
# password_digest:string

# Virtual Attributes:
# password:string
# password_confirmation:string

# has_secure_password creates above two virtual attributes and then bcrypts password and stores that in password_digest.

class User < ApplicationRecord
    has_many :tweets, dependent: :destroy
    has_many :likes

    # The user has many followers:
    has_many :follower_users, foreign_key: :followed_id, class_name: "Relation"
    has_many :followers, through: :follower_users, source: :follower

    # The user follows other users:
    has_many :followed_users, foreign_key: :follower_id, class_name: "Relation"
    has_many :followees, through: :followed_users, source: :followee
    
    has_secure_password

    validates :username, presence: true
    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address." }

    def followed?(user_id)
        User.find_by(id: user_id).followers.pluck(:id).include?(Current.user.id)
    end
end