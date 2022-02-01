# email:string
# password_digest:string

# Virtual Attributes:
# password:string
# password_confirmation:string

# has_secure_password creates above two virtual attributes and then bcrypts password and stores that in password_digest.

class User < ApplicationRecord
    has_many :tweets, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes

    has_many :relations, foreign_key: :follower_id, inverse_of: :follower
    # has_many :followers, through: :relations, class_name: “User”
    
    has_secure_password

    validates :username, presence: true
    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address." }

end