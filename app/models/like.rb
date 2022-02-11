class Like < ApplicationRecord
    belongs_to :tweet, optional: true
    belongs_to :user  
end