class User < ApplicationRecord
  has_many :tweets
  has_one :image, as: :imageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy

  def is_following(user)
  	followees.include?(user)
  end

end