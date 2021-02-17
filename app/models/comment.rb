class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  #validates :content, presence: true

  def find_commenter
    User.find_by(id: user_id)
  end
end
