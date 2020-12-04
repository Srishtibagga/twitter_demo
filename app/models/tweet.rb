class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :retweets
  has_many :images, as: :imageable#, inverse_of: :tweet
  accepts_nested_attributes_for :images,reject_if: proc{|b| b[:image].blank?}

  validates :content, presence: true
  validates :content, length: { maximum: 140 }

  def is_already_like(user)
  	#debugger
  	Like.where(user_id: user.id, tweet_id: id).exists?
  end

  def find_like(user)
  	likes.find_by(user_id: user.id)
  end

  def is_retweet(user)
    Retweet.where(user_id: user.id, tweet_id: id).exists?
  end

  def find_who_tweeted
    User.find_by(id: user_id)
  end
end
