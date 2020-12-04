module TweetsHelper

  def is_my_tweet(tweet)
    current_user.id == tweet.user_id 
  end
  
end
